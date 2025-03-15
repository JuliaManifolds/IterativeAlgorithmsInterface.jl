_doc_init_state = """
    s = initialize_state(p::Problem, a::Algorithm; kwargs...)
    initialize_state!(s::State, p::Problem, a::Algorithm; kwargs...)

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

Return `true` if the [`Algorithm`](@ref) `a` solving the [`Problem`](@ref) `p`
with current [`State`](@ref) `s` is finished
"""
function is_finished(p::Problem, a::Algorithm, s::State)
    scs = get_stopping_criterion_state(s)
    sc = get_stopping_criterion(a)
    return scs(p, a, s, sc)
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
    return solve!(s, p, a; kwargs...)
end

@doc """
    solve!(p::Problem, a::Algorithm, s::State; kwargs...)

Solve the [`Problem`](@ref) `p` using the [`Algorithm`](@ref) `a`
modifying on the [`State`](@ref).

All keyword arguments are passed to the [`initialize_state!`](@ref)`(s, p, a)` function.
"""
function solve!(s::State, p::Problem, a::Algorithm; kwargs...)
    initialize_state!(s, p, a; kwargs...)
    while !is_finished(p, a, s)
        increment!(s)
        step!(p, a, s)
    end
    return s
end

function step! end
@doc """
    step!(s::State, p::Problem, a::Algorithm)

Perform the current step of an [`Algorithm`](@ref) `a` solving [`Problem`](@ref) `p`
modifying the algorithms [`State`](@ref) `s`.
"""
step!(s::State, p::Problem, a::Algorithm)
