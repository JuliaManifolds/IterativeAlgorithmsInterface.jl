module AlgorithmsInterface

include("interface/algorithm.jl")
include("interface/problem.jl")
include("interface/state.jl")

include("interface/interface.jl")

export Algorithm, Problem, State
export step!

end # module AlgorithmsInterface
