----------------------------------------------------------------------------------------------------------

--[=[
    @class prop
    A property object that can be used to store a value, manage its state and listen to changes. Features optional middleware for the two `get` and `set` accessors.
    Provides additional functionality for signal security, type validation, and public and immutable interfaces.
]=]

----------------------------------------------------------------------------------------------------------

--[=[
    @method get
    @within prop

    @param ... any
    @return T

    Returns the current value of the property.
]=]

--[=[
    @method set
    @within prop

    @param new_value T
    @param ... any

    Sets the value of the property to the new value.
]=]

----------------------------------------------------------------------------------------------------------

--[=[
    @prop middleware prop_middleware<T>
    @within prop

    An interface for managing middleware for the `get` and `set` accessors. Refer to the `middleware` class for more information.
]=]

--[=[
    @prop changed var_signal
    @within prop
    
    A signal that fires when the property value changes.
]=]

----------------------------------------------------------------------------------------------------------

--[=[
    @prop signal_security basic_prop<signal_security>
    @within prop

    The security level of the signal. Can be `"base"`, `"immutable"`, or `"restricted"`.

    When this property is set to `"base"`, the `"changed"` signal property will be set to a default signal returned from the `signal.new` function.
    When this property is set to `"immutable"`, the `"changed"` signal property will be set to the `"Immutable"` interface of the signal.
    When this property is set to `"restricted"`, the `"changed"` signal property will be set to the `"Restricted"` interface of the signal.
]=]

--[=[
    @prop type_validator basic_prop<typecheck<T>>
    @within prop

    A function that can be used to validate the type of any new value passed to the property. Returns a boolean and an optional error message.
    The type_validator only runs if the `strict` property is set to `true`. 

    The validator is used after the middleware for both the `get` and `set` accessor transforms the value.
    It also prevents any malformed values from being set to the property.
    
    If no validator is provided and the `strict` property is set to `true`, the property will use the `typeof` function, comparing the type of the new value to the type of the initial value.
]=]

--[=[
    @prop strict basic_prop<boolean>
    @within prop

    A boolean value that determines whether the property should be type-checked before setting a new value.
]=]

--[=[
    @prop type_name basic_prop<string>
    @within prop

    The name of the type of the property. Defaults to the type of the initial value.
]=]

----------------------------------------------------------------------------------------------------------


--[=[
    @prop immutable immutable_prop<T>
    @within prop

    An interface for managing an immutable property. 
    Refer to the `immutable_prop` class for more information.
]=]

--[=[
    @prop public public_prop<T>
    @within prop

    An interface for managing a public property. 
    Refer to the `public_prop` class for more information.
]=]

----------------------------------------------------------------------------------------------------------

--[=[
    @type var_signal signal | restricted_signal | immutable_signal
    @within prop

    Union type for signals with different security levels. 
    Refer to [`signal` documentation](https://khoshal-studio.github.io/luau-signal/api) for more information.
]=]

--[=[
    @type signal_security "base" | "immutable" | "restricted"
    @within prop

    A string that represents the security level of a signal. Can be `"base"`, `"immutable"`, or `"restricted"`.
]=]

--[=[
    @type typecheck<T> (value: T) -> (boolean, string?)
    @within prop

    A function that can be used to validate the type of a value. Returns a boolean and an optional error message.
]=]

--[=[
    @type get<T> (...any) -> T
    @within prop

    A function that returns the current value of a property.
]=]

--[=[
    @type set<T> (new_value: T, ...any) -> ()
    @within prop

    A function that sets the value of a property to a new value.
]=]

----------------------------------------------------------------------------------------------------------

--[=[
    @interface prop_setup<T> 
    @within prop

    @field init T
    @field type_validator typecheck<T>
    @field type_name string?
    @field middleware prop_middleware_info<T>?
    @field signal_security signal_security?
    @field typestrict boolean?

    An object that contains the initial value, type validator, type name, middleware, signal security, and typestrict settings for a property.
    The `init` field is required, while the rest are optional.

    ## Fields
    init - The initial value of the property.
    type_validator - A function that validates the type of the property value. Only runs if `typestrict` is set to `true`. Optional.
    type_name - The name of the type of the property. Do NOT provide this field with a custom type name unless you have a custom type validator, as the validator will always return false. Optional.
    middleware - A table that contains initial middleware for the `get` and `set` accessors of a property. Optional.
    signal_security - The security level of the signal. Refer to the `signal_security` property of the `prop` class for more information. Optional.
]=]

--[=[
    @interface prop_middleware<T>
    @within prop

    @field get middleware<T>
    @field set middleware<T>

    An object that contains middleware for the `get` and `set` accessors of a property.
]=]

--[=[
    @interface prop_middleware_info<T>
    @within prop

    @field get transformer_list<T>?
    @field set transformer_list<T>?

    An optional parameter used to initialize middleware for the `get` and `set` accessors of a property.
]=]

----------------------------------------------------------------------------------------------------------