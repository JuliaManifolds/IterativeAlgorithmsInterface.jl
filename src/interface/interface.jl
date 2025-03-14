function step! end
@doc """
    step!(p::Problem, a::Algorithm, s::State)

Perform the current step of an [`Algorithm`](@ref) `a` solving [`Problem`](@ref) `p`
starting from [`State`](@ref) `s`.
"""
step!(p::Problem, a::Algorithm, s::State)

"""
    solve!(p::PRoblem, a::Algorithm, s::State)
"""
function solve!(p::Problem, a::Algorithm, s::State)