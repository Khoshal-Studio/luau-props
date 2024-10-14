--[=[
    @class middleware
    A middleware object contains a list of transformations that can be applied to a value.
    Can be used to transform a value.
]=]

----------------------------------------------------------------------------------------------------------

--[=[
    @function add
    @within middleware

    @param transformer_arg transformer<T> | transformer_list<T>
    @param index number?

    Adds a transformer to the middleware list. If the `index` argument is provided, the transformer will be inserted at that index.
    Alternatively, a list of transformers can be provided as the first argument to add multiple transformers at once.

    Index defaults to the end of the list.
]=]

--[=[
    @function remove
    @within middleware

    @param index number?
    @param end_index number?

    Removes a transformer from the middleware list. If an `end_index` is provided, all transformers from `index` to `end_index` will be removed. `index` defaults to 1.
    If no arguments are provided, the transformer at the end of the list will be removed.
]=]

--[=[
    @function get
    @within middleware

    @param index number?

    @return transformer<T> | transformer_list<T>

    Returns the transformer at the specified index. If the `index` argument is nil, returns a list of all transformers.
]=]

--[=[
    @function clear
    @within middleware

    Clears all transformers from the middleware list.
]=]

--[=[
    @function transform
    @within middleware

    @param value T
    @param ... any?

    @return T

    Applies all transformers in the middleware list to the value, returning the transformed value.
    If a transformer returns a second value of `true`, the transformation process will be stopped, skipping all remaining transformers and returning the current value.
]=]

----------------------------------------------------------------------------------------------------------

--[=[
    @type transformer (value: T, ...any?) -> (T, boolean?)
    @within middleware

    A function that transforms a value. Returns the transformed value and an optional boolean flag to stop the transformation process.
]=]

--[=[
    @type transformer_list list<transformer<T>>
    @within middleware

    A list of transformers that can be applied to a value.
]=]

----------------------------------------------------------------------------------------------------------

--[=[
    @interface middleware<T>
    @within middleware

    @field get ((index: number) -> transformer<T>?) & (() -> transformer_list<T>)
    @field add ((transformer: transformer<T>, index: number?) -> ()) & (list: transformer_list<T>, start_index: number?) -> ()
    @field remove ((index: number?) -> ()) & (start_index: number?, end_index: number) -> ()
    @field clear () -> ()
    @field transform (value: T, ...any?) -> T
]=]

----------------------------------------------------------------------------------------------------------