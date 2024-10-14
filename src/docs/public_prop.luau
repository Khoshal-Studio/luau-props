--[=[
    @class public_prop

    A public interface of a `prop` object that can be changed after initialization. Contains a `get` and a `set` accessor, and a `changed` signal.
]=]

-------------------------------------------------------------------------------------------------------

--[=[
    @function get
    @within public_prop

    @param ... any
    @return T

    Returns the current value of the property.
]=]

--[=[
    @function set
    @within public_prop

    @param new_value T
    @param ... any

    Sets the value of the property to the new value.
]=]

-------------------------------------------------------------------------------------------------------

--[=[
    @prop changed var_signal
    @within public_prop

    A signal that fires when the property value changes.
]=]

-------------------------------------------------------------------------------------------------------

--[=[
    @interface public_prop<T>
    @within public_prop

    @field get get<T>
    @field set set<T>
    @field changed var_signal

    A public interface of a `prop` object that can be changed after initialization. Contains a `get` and a `set` accessor, and a `changed` signal.
]=]

-------------------------------------------------------------------------------------------------------