--!strict

----------------------------------------------------------------------------------------------------------------

local classes = script.Parent.Parent:WaitForChild("classes")
local t = require(classes:WaitForChild("t"))
local types = require(script.Parent.Parent:WaitForChild("types"))

----------------------------------------------------------------------------------------------------------------

type transformer<T> = types.transformer<T>
type transformer_list<T> = types.transformer_list<T>
type middleware<T> = types.middleware<T>

----------------------------------------------------------------------------------------------------------------

local methods = {
    add = function<T>(local_list: transformer_list<T>)
        return function(...)
            local args = {...}

            local a1 = args[1]
            local a2 = args[2]

            if typeof(a1) == "table" then
                local transformer_list = a1
                local start_index = a2

                for index, transformer in ipairs(transformer_list) do
                    assert(t.callback(transformer), "Invalid transformer argument, expected function, got: " .. typeof(transformer))

                    if start_index then
                        table.insert(local_list, start_index + index - 1, transformer)
                    else
                        table.insert(local_list, transformer)
                    end
                end
            elseif typeof(a1) == "function" then
                local transformer = a1
                local index = a2

                assert(t.callback(transformer), "Invalid transformer argument, expected function, got: " .. typeof(transformer))
                    
                if index then
                    table.insert(local_list, index, transformer)
                else
                    table.insert(local_list, transformer)
                end
            else
                error(string.format("Invalid argument type: %s\nExpected type: %s", typeof(a1), "function or table"))
            end
        end :: any
    end,

    remove = function<T>(local_list: transformer_list<T>)
        return function(...)
            local args = {...}

            local a1 = args[1]
            local a2 = args[2]

            if a1 and a2 then
                local start_index = a1
                local end_index = a2
            
                for index = end_index, start_index, -1 do
                    table.remove(local_list, index)
                end
            elseif a1 and not a2 then
                local index = a1
                table.remove(local_list, index)
            else
                error("Invalid argument count. Expected 1 or 2 arguments.")
            end
        end :: any
    end,

    get = function<T>(local_list)
        return function(index: number?): transformer<T> | transformer_list<T>
            if index then
                return local_list[index]
            else
                return {table.unpack(local_list :: any)}
            end
        end :: any
    end,

    clear = function<T>(local_list)
        return function()
            local_list = {}
        end
    end,

    transform = function<T>(local_list : transformer_list<T>) 
        return function(value: T, ...: any?): T
            local current_value = value
            
            for _, transformer in ipairs(local_list) do
                local result, cancel = transformer(current_value, ...)

                if cancel == true then
                    break
                end

                current_value = result :: any
            end

            return current_value
        end
    end
}


local function new<T>(list: transformer_list<T>?): middleware<T>
    local local_list: transformer_list<T> = list or {}

    local add = methods.add(local_list)
    local remove = methods.remove(local_list)
    local get = methods.get(local_list)
    local clear = methods.clear(local_list)
    local transform = methods.transform(local_list)

    local middleware_obj: middleware<T> = {
        add = add,
        remove = remove,
        get = get,
        clear = clear,
        transform = transform
    }
    
    return middleware_obj
end

----------------------------------------------------------------------------------------------------------------

return {
    new = new
}

----------------------------------------------------------------------------------------------------------------