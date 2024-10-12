--!strict

-------------------------------------------------------------------------------------------

local signal = require(script.Parent:WaitForChild("classes"):WaitForChild("signal"))

-------------------------------------------------------------------------------------------

type signal = signal.signal
type restricted_signal = signal.restricted_signal
type immutable_signal = signal.immutable_signal
type var_signal = signal | restricted_signal | immutable_signal

-------------------------------------------------------------------------------------------

export type list<V> = {[number] : V}
export type dict<V> = {[string] : V}
export type table<K, V> = {[K] : V}

-------------------------------------------------------------------------------------------

export type get<T> = (...any?) -> T
export type set<T> = (new_value : T, ...any?) -> ()
export type signal_security = "base" | "restricted" | "immutable"
export type typecheck<T> = (value: T) -> (boolean, string?)

-------------------------------------------------------------------------------------------

export type immutable_prop<T> = {
    get: get<T>,

    changed: var_signal,
}

export type public_prop<T> = {
    get: get<T>,
    set: set<T>,
    
    changed: var_signal,
}

-------------------------------------------------------------------------------------------

export type transformer<T> = (value: T, ...any?) -> (T?, boolean?)
export type transformer_list<T> = list<transformer<T>>

export type prop_middleware<T> = {
    get: middleware<T>,
    set: middleware<T>,
}

export type middleware<T> = {
    get: ((index: number) -> transformer<T>?)
        & (() -> transformer_list<T>),

    add: ((transformer: transformer<T>, index: number?) -> ()) 
        & (list: transformer_list<T>, start_index: number?) -> (),
        
    remove: ((index: number?) -> ()) 
        & (start_index: number?, end_index: number) -> (),

    clear: () -> (),
    
    transform: (value: T, ...any?) -> T,
}

export type prop_middleware_info<T> = {
    get: transformer_list<T>?,
    set: transformer_list<T>?,
}

export type prop<T> = {
    get: get<T>,
    set: set<T>,

    middleware: prop_middleware<T>,

    signal_security: {
        get: () -> signal_security,
        set: (new_security: signal_security) -> (),
    },

    type_validator: {
        get: () -> typecheck<T>,
        set: (new_validator: typecheck<T>) -> (),
    },

    strict: {
        get: () -> boolean,
        set: (new_value: boolean) -> (),
    },

    type_name: {
        get: () -> string,
        set: (new_name: string) -> (),
    },

    changed: signal | restricted_signal | immutable_signal, 

    immutable: immutable_prop<T>,
    public: public_prop<T>,
}

export type prop_setup<T> = {
    init: T,
    type_validator: typecheck<T>?,
    type_name: string?,
    middleware: prop_middleware_info<T>?,
    signal_security: signal_security?,
    typestrict: boolean?,
}

export type object_base<T> = {
    __type: T
}

-------------------------------------------------------------------------------------------

return nil

-------------------------------------------------------------------------------------------