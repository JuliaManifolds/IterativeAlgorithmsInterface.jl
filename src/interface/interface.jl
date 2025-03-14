function step! end
"""
    step!(p::Problem, a::Algorithm, s::State)

Perform the current step of an [`Algorithm`](@ref) `a` solving [`Problem`](@ref) `p`
starting from [`State`](@ref) `s`.
"""
step!(p::Problem, a::Algorithm, s::State)
