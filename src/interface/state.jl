"""
    State

An abstract type to represent the state an iterative algorithm is in.

The state consists of any information that describes the current step the algorithm is in
and keeps all information needed from one step to the next.

Usually this should include

* `iteration` – the current iteration step ``k`` that is is currently performed or was last performed
* `stopping_criterion` – a [`StoppingCriterion`](@ref) that indicates whether the algorithm
  will stop after this iteration or has stopped.
* `iterate` the current iterate ``x^{(k)}```.

These variable names given in this list are the defaults for which the accessors are implemented,
such that if your concrete `MyState <: State` follows this convention, you do not have to reimplement
their accessors.
"""
abstract type State end

"""
    get_iteration(s::State)

Return the current iteration a state either is currently performing or was last performed
"""
get_iteration(s::State) = s.iteration
