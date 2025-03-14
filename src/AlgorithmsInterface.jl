@doc raw"""
🏔️ AlgorithmsInterface.jl: an interface for iterative algorithms in Julia

* 📚 Documentation: [juliamanifolds.github.io/AlgorithmsInterface.jl/](https://juliamanifolds.github.io/AlgorithmsInterface.jl/)
* 📦 Repository: [github.com/JuliaManifolds/AlgorithmsInterface.jl](https://github.com/JuliaManifolds/AlgorithmsInterface.jl)
* 💬 Discussions: [github.com/JuliaManifolds/AlgorithmsInterface.jl/discussions](https://github.com/JuliaManifolds/AlgorithmsInterface.jl/discussions)
* 🎯 Issues: [github.com/JuliaManifolds/AlgorithmsInterface.jl/issues](https://github.com/JuliaManifolds/AlgorithmsInterface.jl/issues)
"""
module AlgorithmsInterface

using Dates: Millisecond, Nanosecond, Period, canonicalize, value

include("interface/algorithm.jl")
include("interface/problem.jl")
include("interface/state.jl")
include("interface/interface.jl")

include("stopping_criterion.jl")

export Algorithm, Problem, State
export StoppingCriterion
export StopAfter, StopAfterIteration
export is_finished
export initialize_state, initialize_state!, is_finished
export get_iteration
export step!, solve, solve!

end # module AlgorithmsInterface
