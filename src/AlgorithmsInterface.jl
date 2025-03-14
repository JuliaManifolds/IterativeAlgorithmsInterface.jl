module AlgorithmsInterface

include("interface/algorithm.jl")
include("interface/problem.jl")
include("interface/state.jl")
include("interface/interface.jl")

include("stopping_criterion.jl")

export Algorithm, Problem, State
export get_iteration
export step!

end # module AlgorithmsInterface
