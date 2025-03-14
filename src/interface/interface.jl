function step! end
@doc """
    step!(p::Problem, a::Algorithm, s::State)

Perform the current step of an [`Algorithm`](@ref) `a` solving [`Problem`](@ref) `p`
starting from [`State`](@ref) `s`.
"""
step!(p::Problem, a::Algorithm, s::State)


@doc """
    solve(p::Problem, a::Algorithm; kwargs...)

Solve the Solve the [`Problem`](@ref) `p` using the [`Algorithm`](@ref) `a`.
The keyword arguments `kwargs...` have to provide enough details such that
the corresponding state initialisation [`initialize_state`](@ref)`(p,a)`
returns a state.

By default this method continues to call [`solve!`](@ref).
"""
function solve(p::Problem, a::Algorithm; kwargs...)
    s = initialize_state(p, a)
    return solve!(p, a, s)
end

@doc """
    solve!(p::Problem, a::Algorithm, s::State)

Solve the [`Problem`](@ref) `p` using the [`Algorithm`](@ref) `a`
working on the [`State`](@ref).
"""
solve!(p::Problem, a::Algorithm, s::State)
