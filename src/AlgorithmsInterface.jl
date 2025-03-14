module AlgorithmsInterface

using Dates: Millisecond, Nanosecond, Period, canonicalize, value

include("interface/algorithm.jl")
include("interface/problem.jl")
include("interface/state.jl")
include("interface/interface.jl")

include("stopping_criterion.jl")

export Algorithm, Problem, State
export get_iteration
export step!

end # module AlgorithmsInterface
