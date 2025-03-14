_doc_init_state = """
    s = initialize_state(p::Problem, a::Algorithm; kwargs...)
    initialize_state!(p::Problem, a::Algorithm, s::State; kwargs...)

Initialize a [`State`](@ref) `s` base on a [`Problem`](@ref) `p` and an [`Algorithm`](@ref).
The `kwargs...` should allow to initialize for example the initial point.
This can be done in-place of `s`, then only values that did change have to be provided.
"""

function initialize_state end

@doc "$(_doc_init_state)"
initialize_state(::Problem, ::Algorithm; kwargs...)

function initialize_state! end

@doc "$(_doc_init_state)"
initialize_state!(::State, ::Problem, ::Algorithm; kwargs...)

@doc """
    is_finished(p::Problem, a::Algorithm, s::State)
"""
function is_finished(p::Problem, a::Algorithm, s::State)
    sc = get_stopping_criterion(s)
    return sc(p, a, s)
end

# has to be defined before used in solve but is documented alphabetically after

@doc """
    solve(p::Problem, a::Algorithm; kwargs...)

Solve the [`Problem`](@ref) `p` using the [`Algorithm`](@ref) `a`.
The keyword arguments `kwargs...` have to provide enough details such that
the corresponding state initialisation [`initialize_state`](@ref)`(p,a)`
returns a state.

By default this method continues to call [`solve!`](@ref).
"""
function solve(p::Problem, a::Algorithm; kwargs...)
    s = initialize_state(p, a; kwargs...)
    return solve!(p, a, s; kwargs...)
end

@doc """
    solve!(p::Problem, a::Algorithm, s::State; kwargs...)

Solve the [`Problem`](@ref) `p` using the [`Algorithm`](@ref) `a`
working on the [`State`](@ref).

All keyword arguments are passed to the [`initialize_state!`](@ref) function.
"""
function solve!(p::Problem, a::Algorithm, s::State; kwargs...)
    initialize_state!(p, a, s; kwargs...)
    while !is_finished(p, a, s)
        increment!(s)
        step!(p, a, s)
    end
end

function step! end
@doc """
    step!(p::Problem, a::Algorithm, s::State)

Perform the current step of an [`Algorithm`](@ref) `a` solving [`Problem`](@ref) `p`
starting from [`State`](@ref) `s`.
"""
step!(p::Problem, a::Algorithm, s::State)
