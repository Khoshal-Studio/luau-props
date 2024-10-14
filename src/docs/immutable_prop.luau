--[=[
    @class immutable_prop

    An immutable derivative of a `prop` object that cannot be changed after initialization. Contains a `get` accessor and a `changed` signal.
]=]

-------------------------------------------------------------------------------------------------------

--[=[
    @method get
    @within immutable_prop

    @param ... any
    @return T

    Returns the current value of the property.
]=]

-------------------------------------------------------------------------------------------------------

--[=[
    @prop changed var_signal
    @within immutable_prop
]=]

-------------------------------------------------------------------------------------------------------

--[=[
    @interface immutable_prop<T>
    @within immutable_prop

    @field get get<T>
    @field changed var_signal

    An immutable derivative of a `prop` object that cannot be changed after initialization. Contains a `get` accessor and a `changed` signal.
]=]

-------------------------------------------------------------------------------------------------------