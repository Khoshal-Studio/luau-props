--[=[
    @class module

    The `props` module.
]=]

-----------------------------------------------------------------------------------------------

--[=[
    @method new
    @within module

    @param config prop_setup<T>
    @return prop<T>

    Creates a new property with the given configuration. Refer to the `prop_setup` type for more information.
]=]

-----------------------------------------------------------------------------------------------

--[=[
    @prop t module
    @within module

    Runtime typechecker module. A dependency of the `props` module. Can be used to create validator functions for the `type_validator` property.
    Refer to the [Github repository](https://github.com/osyrisrblx/t) for more information.
]=]

--[=[
    @prop signal module
    @within module

    The signal module. A dependency of the `props` module. Can be used to create signals for the `changed` property.
    Refer to the [documentation](https://khoshal-studio.github.io/luau-signal/api) for more information.
]=]

-----------------------------------------------------------------------------------------------

--[=[
    @interface module
    @within module

    A Luau script that returns exactly one value.
]=]

-----------------------------------------------------------------------------------------------
