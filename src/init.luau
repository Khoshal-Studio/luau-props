--!strict

----------------------------------------------------------------------------------------------------------------

local classes = script:WaitForChild("classes")
local types = require(script:WaitForChild("types"))

local t = require(classes:WaitForChild("t"))
local signal = require(classes:WaitForChild("signal"))
local middleware = require(classes:WaitForChild("middleware"))

----------------------------------------------------------------------------------------------------------------

type signal = signal.signal
type restricted_signal = signal.restricted_signal
export type get<T> = types.get<T>
export type set<T> = types.set<T>
export type immutable_prop<T> = types.immutable_prop<T>
export type prop<T> = types.prop<T>
export type public_prop<T> = types.public_prop<T>
export type signal_security = types.signal_security
export type object_base<T> = types.object_base<T>
export type transformer<T> = types.transformer<T>
export type middleware<T> = types.middleware<T>
export type prop_middleware_info<T> = types.prop_middleware_info<T>
export type prop_setup<T> = types.prop_setup<T>
export type typecheck<T> = types.typecheck<T>

----------------------------------------------------------------------------------------------------------------

local signal_security_type = t.literal("base", "restricted", "immutable")

local function default_validator<T>(value): (boolean, string?)
    return true, "Default type validator, always returns true"
end

----------------------------------------------------------------------------------------------------------------

local function new<T, init_type>(config: prop_setup<T>): prop<T>
    local prop : prop<T> = nil

    --[[----------------------------------------------------------------------]]--

    local current_value = config.init
    local changed = signal.new()
    local prop_type = config.type_name or typeof(current_value)
    local type_validator = config.type_validator or default_validator :: any
    local typestrict = config.typestrict or false
    local middleware_info = config.middleware
    local signal_security: signal_security = config.signal_security or "immutable"

    --[[----------------------------------------------------------------------]]--

    local function get(...: any?)
        local transformed = prop.middleware.get.transform(current_value, ...)

        if typestrict then 
            local type_success, type_error = type_validator(transformed)
            if not type_success then
                warn("Type validation failed for get attempt, expected: " .. prop_type .. ", got: " .. typeof(transformed))
                warn(type_error or "")
            end            
        end

        return transformed
    end

    local function set(new_value: T, ...: any?)
        if typestrict then
            local type_success, type_error = type_validator(new_value)
            if not type_success then
                warn("Type validation failed for set attempt, expected: " .. prop_type .. ", got: " .. typeof(new_value))
                warn(type_error or "")
            end
        end

        local transformed = prop.middleware.set.transform(new_value, ...)

        if typestrict then
            local type_success, type_error = type_validator(transformed)
            if not type_success then
                warn("Internal transformer type validation failed for set attempt, expected: " .. prop_type .. ", got: " .. typeof(transformed))
                warn(type_error or "")
                return
            end
        end

        if transformed == prop_type then
            return
        end

        current_value = new_value
        
        changed:Fire(transformed)
    end

    --[[----------------------------------------------------------------------]]--

    local get_middleware = middleware.new(if middleware_info and middleware_info.get then middleware_info.get else nil)
    local set_middleware = middleware.new(if middleware_info and middleware_info.set then middleware_info.set else nil)
    
    --[[----------------------------------------------------------------------]]--

    local immutable = {
        get = get,
        
        changed = changed.Immutable
    }

    local public = {
        get = get,
        set = set,

        changed = changed.Immutable
    }

    --[[----------------------------------------------------------------------]]--

    local function on_signal_security_set(new_value: signal_security)
        if new_value == "restricted" then
            prop.immutable.changed = changed.Restricted
            prop.public.changed = changed.Restricted
        elseif new_value == "immutable" then
            prop.immutable.changed = changed.Immutable
            prop.public.changed = changed.Immutable
        elseif new_value == "base" then
            prop.immutable.changed = changed
            prop.public.changed = changed
        end
    end

    --[[----------------------------------------------------------------------]]--

    prop = {
        get = get,
        set = set,

        middleware = {
            get = get_middleware,
            set = set_middleware
        },

        signal_security = {
            get = function()
                return signal_security
            end,

            set = function(new_value: signal_security)
                local type_success, type_error = signal_security_type(new_value)
                if not type_success then
                    warn("Invalid type for signal_security, expected: signal_security, got: " .. typeof(new_value))
                    warn(type_error or "")
                    return
                end

                if signal_security == new_value then
                    return
                end

                signal_security = new_value
                on_signal_security_set(new_value)
            end
        },

        strict = {
            get = function()
                return typestrict
            end,

            set = function(new_value: boolean)
                if typeof(new_value) ~= "boolean" then
                    warn("Invalid type for typestrict, expected: boolean, got: " .. typeof(new_value))
                    return
                end

                if typestrict == new_value then
                    return
                end

                typestrict = new_value
            end
        },

        type_validator = {
            get = function()
                return type_validator
            end,

            set = function(new_value: typecheck<T>)
                local type_success, type_error = t.callback(new_value)
                if not type_success then
                    warn("Invalid type for type_validator, expected: function, got: " .. typeof(new_value))
                    warn(type_error or "")
                    return
                end

                local return_value = new_value(current_value)

                if type(return_value) ~= "boolean" then
                    warn("Invalid return type for type_validator, expected: boolean, got: " .. typeof(return_value))
                    return
                end

                if type_validator == new_value then
                    return
                end

                type_validator = new_value
            end
        },

        type_name = {
            get = function()
                return prop_type
            end,

            set = function(new_value: string)
                if typeof(new_value) ~= "string" then
                    warn("Invalid type for type_name, expected: string, got: " .. typeof(new_value))
                    return
                end

                if new_value == prop_type then
                    return
                end

                prop_type = new_value
            end
        },

        changed = changed,
        
        immutable = immutable,
        public = public
    }

    --[[----------------------------------------------------------------------]]--

    return prop
end

----------------------------------------------------------------------------------------------------------------


return {
    new = new,
    t = t,
    signal = signal
}

----------------------------------------------------------------------------------------------------------------