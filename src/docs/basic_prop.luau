----------------------------------------------------------------------------------------------------------

--[=[
    @class basic_prop

    A basic interface of a `prop` object that can be changed after initialization. Contains a `get` and a `set` accessor.
    Cannot be created. Used for managing the `signal_security`, `type_validator`, `strict`, and `type_name` properties of a `prop` object.
]=]

----------------------------------------------------------------------------------------------------------

--[=[
    @function get
    @within basic_prop

    @param ... any
    @return T

    Returns the current value of the property.
]=]

--[=[
    @function set
    @within basic_prop

    @param new_value T
    @param ... any

    Sets the value of the property to the new value.
]=]

----------------------------------------------------------------------------------------------------------

--[=[
    @interface basic_prop<T>
    @within basic_prop

    @field get get<T>
    @field set set<T>

    A basic interface of a `prop` object that can be changed after initialization. Contains a `get` and a `set` accessor.
]=]

----------------------------------------------------------------------------------------------------------