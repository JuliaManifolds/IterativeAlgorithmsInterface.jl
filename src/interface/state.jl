@doc """
    State

An abstract type to represent the state an iterative algorithm is in.

The state consists of any information that describes the current step the algorithm is in
and keeps all information needed from one step to the next.

Usually this should include

* `iteration` – the current iteration step ``k`` that is is currently performed or was last performed
* `stopping_criterion` – a `StoppingCriterion` that indicates whether the algorithm
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

The default assumes that the current iteration is stored in `s.iteration`.
"""
get_iteration(s::State) = s.iteration

function initialize_state end
@doc """
    initialize_state(p::Problem, a::Algorithm, kwargs...)

Initialise a [`State`](@ref) `s` for a [`Problem`](@ref) `p` and an [`Algorithm`](@ref) `a`,
where the keyword arguments should both uniquely identify the state and provide enough
information to call its constructor.
"""
initialize_state(::Problem, ::Algorithm, kwargs...)
