--!strict

----------------------------------------------------------------------------------------------------------------

local module = {}

----------------------------------------------------------------------------------------------------------------

local props_types : nil = require(script:WaitForChild("props_types"))
local signal = require(script:WaitForChild("signal"))

type signal = signal.signal
type restricted_signal = signal.restricted_signal
type fire_fn = signal.fire_fn

----------------------------------------------------------------------------------------------------------------

export type get<T> = props_types.get<T>
export type set<T> = props_types.set<T>

export type user_get<T> = props_types.user_get<T>
export type user_set<T> = props_types.user_set<T>

export type immutable_attribute<T> = props_types.immutable_attribute<T>
export type mutable_attribute<T> = props_types.mutable_attribute<T>

export type object_base<T> = props_types.object_base<T>

----------------------------------------------------------------------------------------------------------------

--[=[
    ### `module.easy_proxy(current_value : T, ... : any?): T`
        
    @param current_value : `T`
    @param ... : `any?`
    @return `T`

    #### Description
    A function that takes a value of type T and returns it.
    Used as a default get and set function for attributes if the user does not provide one.
    This function is used to make the user's life easier by providing a default get and set function for attributes.

    #### Examples
    ```lua
    local attribute = module.mutable(0, module.easy_proxy, module.easy_proxy)
    print(attribute.get()) -- Returns 0, no transformation
    ```
]=]
module.easy_proxy = function<T>(current_value : T, ... : any?): T
    return current_value
end

----------------------------------------------------------------------------------------------------------------

--[=[
    ### `module.mutable(init_value : T, get_handler : user_get<T>?, set_handler : user_set<T>?) : mutable_attribute<T>`
        
    @param init_value : `T`
    @param get_handler : `user_get<T>?`
    @param set_handler : `user_set<T>?`
    @return `mutable_attribute<T>`

    ### Description
    A function that creates a mutable attribute with handlers for getting and setting the value.\
    The handlers are optional, if not provided, the default handlers will be used.

    ### Arguments

    #### `init_value : T`
    The initial value is the value that the attribute will have when it is created.\
    The initial value can be of any type `T`.
    
    #### `get_handler : user_get<T>?`
    The get handler is a function that takes the current value of type `T` and returns the current value.\
    Transformations can be done to the current value before getting it, for example, rounding the value for display on the UI.
    If not provided, the default handler will be used.

    #### `set_handler : user_set<T>?`
    The set handler is a function that takes the new value of type `T` and returns the new value.\
    Transformations can be done to the new value before setting it, for example, rounding the value before setting it to the attribute.
    If not provided, the default handler will be used.

    ### Return Values

    #### `property : mutable_attribute<T>`
    The attribute object that has three properties, `get`, `set`, and `changed`.

    ##### `get : (...any) -> T`
    A function that gets the current value of the attribute, after passing it through the `get` handler.

    ##### `set : (new_value : T, silent : boolean?) -> ()`
    A function that sets the new value of the attribute.\
    If silent is true, the `changed` signal will not fire.

    ##### `changed : signal`
    A signal that fires when the attribute changes.\
    The signal passes the new value and the previous value as arguments to the connected functions.\

    #### Examples
    ```lua
    local attribute = module.mutable(0, module.easy_proxy, module.easy_proxy)
    print(attribute.get()) -- Returns 0, no transformation
    attribute.set(1) -- Changes the value to 1
    print(attribute.get())
    ```
]=]
module.mutable = function<T>(init_value : T, get_handler : user_get<T>?, set_handler : user_set<T>?) : mutable_attribute<T>
    local get = get_handler or module.easy_proxy :: any
    local set = set_handler or module.easy_proxy :: any

    local attribute : mutable_attribute<T>
    local current_value : T = init_value

    local function get_proxy(...: any): T
        return get(current_value, ...)
    end

    local function set_proxy(new_value : T, silent : boolean?, ...: any): ()
        local value = set(new_value, ...)
        if value == current_value then
            return
        end
        
        local previous_value = current_value
        current_value = set(new_value, ...)
        
        if not silent then
            attribute.changed:Fire(current_value, previous_value)
        end
    end

    attribute = {
        get = get_proxy,
        set = set_proxy,
        changed = signal.signal.new()
    }

    return attribute
end

--[=[
    ### `module.immutable(init_value : T, get_handler : user_get<T>?) : immutable_attribute<T>, fire_fn, set<T>`
        
    @param init_value : `T`
    @param get_handler : `user_get<T>?`
    @return `immutable_attribute<T>, fire_fn, set<T>`

    ### Description
    A function that creates an immutable attribute with a handler for getting the value.\
    The handler is optional, if not provided, the default handler will be used.

    ### Arguments

    #### `init_value : T`
    The initial value is the value that the attribute will have when it is created.\
    The initial value can be of any type `T`.
    
    #### `get_handler : user_get<T>?`
    The get handler is a function that takes the current value of type `T` and returns the current value.\
    Transformations can be done to the current value before getting it, for example, rounding the value for display on the UI.
    If not provided, the default handler will be used.

    ### Return Values

    #### `property : immutable_attribute<T>`
    The attribute object that has two properties, `get` and `changed`.

    ##### `get : (...any) -> T`
    A function that gets the current value of the attribute, after passing it through the `get` handler.

    ##### `changed : signal`
    A restricted signal that fires when the attribute changes.\
    The signal passes the new value and the previous value as arguments to the connected functions.\

    #### `fire_fn : (...any) -> ()`
    A function that fires the signal with the new value and the previous value as arguments, along with any other arguments passed to the function.

    #### `set<T> : (new_value : T, silent : boolean?) -> ()`
    A function that sets the new value of the attribute.

    #### Examples
    ```lua
    local attribute, fire, set = module.immutable(0, module.easy_proxy)
    print(attribute.get()) -- Returns 0, no transformation
    set(1) -- Changes the value to 1
    print(attribute.get()) -- Returns 1, no transformation
    fire(2) -- Fires the signal with the new value 2 and the previous value 1
    ```
]=]
module.immutable = function<T>(init_value : T, get_handler : user_get<T>?) : (immutable_attribute<T>, fire_fn, set<T>)
    local get = get_handler or module.easy_proxy :: any

    local attribute : immutable_attribute<T>
    local current_value : T = init_value
    local restricted_signal: restricted_signal, fire: (...any) -> () = signal.restricted_signal.new()

    local function fire_proxy(...: any): ()
        fire(current_value, ...)
    end
    
    local function get_proxy(...: any): T
        return get(current_value, ...)
    end

    local function set(new_value : T, silent : boolean?): ()
        if new_value == current_value then
            return
        end
        
        local previous_value: T = current_value
        current_value = new_value
        
        if not silent then
            fire_proxy(current_value, previous_value)
        end
    end

    attribute = {
        get = get_proxy,
        changed = restricted_signal
    }

    return attribute, fire_proxy, set
end

----------------------------------------------------------------------------------------------------------------

module.signal = signal

----------------------------------------------------------------------------------------------------------------

return module

----------------------------------------------------------------------------------------------------------------