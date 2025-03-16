# 🧮 AlgorithmsInterface.jl

`AlgorithmsInterface.jl` is a Julia package to provide a common interface to run iterative tasks. **Algorithm** here refers to an iterative sequence of commands, that are run until a certain stopping criterion is met.

# Statement of need

A first approach to algorithms is a simple for-loop for a maximum number of iterations.
Using an interface instead allows to both specify different criteria to stop easily, even in their combination.
Furthermore a generic interface allows to both “hook into” an algorithm easily as well as combining them.

A common interface for algorithms allows to reuse common code – especially stopping criteria, but especially also logging, debug, recording, and caching capabilities.
Finally, a common interface also allows to easily combine existing algorithms, hence enhancing interoperability, for example using one algorithm as a sub routine of another one.

# Main features

See the [intial discussion](https://github.com/JuliaManifolds/AlgorithmsInterface.jl/discussions/1)
as well as the [overview on existing things](https://github.com/JuliaManifolds/AlgorithmsInterface.jl/discussions/2)

## Further ideas

* generic stopping criteria `<:AbstractStoppingCriterion`
  * `StopAfterIteration(i)` for example
* a factory that turns certain keywords like `maxiter=` into stopping criteria
* still support the `stopping_criterion=` ideas from `Manopt.jl`
* by default `stop()` from above would check such a stopping criterion
* generic debug and record functionality – together with hooks even

## Possible extensions

* to `LineSearches.jl`
*
