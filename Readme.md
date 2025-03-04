# IterativeAlgorithmsInterface.jl

`IterativeAlgorithmsInterface.jl` is a Julia package tp provide a common interface to run iterative tasks. **Algorith** here refers to an iterative sequence of commands, that are run until a certain stopping criterion is met.

# Statement of need

A first approach to algorithms is a simple for-loop for a maximum number of iterations.
Using an interface instead allows to both specify different criteria to stop easily, even in their combination.
Furthermore a generic interface allows to both “hok into” an algorithm easily as well as combining them.

A common interface for algorithms allows to reuse common code – especially stopping criteria, but especially also logging, debug, recording, and caching capabilities. Finally, a common interface also allows to easily combine existing algorithms, hence enhancing interoperability, for example using one algorithm as a sub routine of another one.

# Main features

We consider solving _Tasks_, which consist of a

* `AbstractProblem` to solve, which contains all information that is static to the problem and usually does not change during the iterations, this might for example be a cost function and its gradient in an optimisation problem
* An `AbstractAlgorithmState` that both specifies which algorithm to use to _solve_ the problem, but also stores all parameters that an algorithm needs as well as everything the algorithm needs to store between two iterations.

This generic data structures are accompanied by the methods

* `step!(problem::Problem, state::AlgorithmState, k)` to perform the `k`th iteration of the algorithm.
* `solve!(problem::Problem, state::AlgorithmState)` to solve a problem with a given algorithm, which is identified by the `AlgorithmState`.
* `stop(problem::Problem, state::AlgorithmState)` to check whether the algorithm should stop.

where the first is the main one to implement for a new algorithm.

# Further ideas

* generic stopping criteria `<:AbstractStoppingCriterion`
  * `StopAfterIteration(i)` for example
* a factory that turns certain keywords like `maxiter=` into stopping criteria
* still support the `stopping_criterion=` ideas from `Manopt.jl`
* by default `stop()` from above would check such a stopping criterion
* generic debug and record functionality – together with hooks even

# possible extensions

* to `LineSearches.jl`
*
