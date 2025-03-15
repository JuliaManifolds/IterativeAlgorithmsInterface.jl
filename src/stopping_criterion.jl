@doc """
    StoppingCriterion

An abstract type to represent a stopping criterion.

A concrete [`StoppingCriterion`](@ref) `sc` should also implement a
[`initialize_state(problem::Problem, algorithm::Algorithm, sc::StoppingCriterion; kwargs...)`](@ref) function to create its accompanying
[`StoppingCriterionState`](@ref).
as well as the corresponting mutating variant to reset such a [`StoppingCriterionState`](@ref).

It should usually implement

* `indicates_convergence(sc)` a boolean whether or not this stopping criterion would indicate
  that the algorithm has converged, if it indicates to stop.
"""
abstract type StoppingCriterion end

@doc """
    StoppingCriterionState

An abstract type to represent a stopping criterion state withinn a [`State`](@ref).

Any concrete stopping criterion should be implemented as a functor,
that takes the “usual tuple” `(problem, algorithm, state, stopping_criterion)`
of a [`Problem`](@ref) `p`, an [`Algorithm`](@ref) and a [`State`](@ref) as input,
as well as the corresponding [`StoppingCriterion`](@ref). Though this is usually stored¨
in the [`Algorithm`](@ref) `algorithm`, the extra parameter allows both for more flexibility and
for multiple dispatch.
The concrete [`StoppingCriterionState`](@ref) should be part of the [`State`](@ref) `state`.

The functor might modify the stopping criterion state.
"""
abstract type StoppingCriterionState end

function get_reason end
@doc """
    get_reason(sc::StoppingCriterion, scs::StoppingCriterionState)

Provide a reason in human readable text as to why a [`StoppingCriterion`](@ref) `sc
with [`StoppingCriterionState`](@ref) `scs` indicated to stop.
If it does not indicate to stop, this should return an empty string.

Providing the iteration at which this indicated to stop in the reason would be preferable.
"""
get_reason(::StoppingCriterion, ::StoppingCriterionState)

function indicates_convergence end
@doc """
    indicates_convergence(sc::StoppingCriterion)

Return whether or not a [`StoppingCriterion`](@ref) `sc` indicates convergence.
"""
indicates_convergence(sc::StoppingCriterion)

@doc """
    indicates_convergence(sc::StoppingCriterion, ::StoppingCriterionState)

Return whether or not a [`StoppingCriterion`](@ref) `sc` indicates convergence
when it is in [`StoppingCriterionState`](@ref)

By default this checks whether the [`StoppingCriterion`](@ref) has actually stopped.
If so it returns whether `sc` itself indicates convergence, otherwise it returns `false`,
since the algorithm has then not yet stopped.
"""
function indicates_convergence(sc::StoppingCriterion, scs::StoppingCriterionState)
    return length(get_reason(sc, scs)) > 0 ? indicates_convergence(sc) : false
end

function get_summary end
@doc """
    get_summary(sc::StoppingCriterion, scs::StoppingCriterionState)

Provide a summary of the status of a stopping criterion – its parameters and whether
it currently indicates to stop. It should not be longer than one line

# Example

For the [`StopAfterIteration`](@ref) criterion, the summary looks like

```
Max Iterations (15): not reached
```
"""
get_summary(sc::StoppingCriterion, scs::StoppingCriterionState)

@doc raw"""
    StopAfterIteration <: StoppingCriterion

A simple stopping criterion to stop after a maximal number of iterations.

# Fields

* `max_iterations`  stores the maximal iteration number where to stop at

# Constructor

    StopAfterIteration(maxIter)

initialize the functor to indicate to stop after `maxIter` iterations.
"""
struct StopAfterIteration <: StoppingCriterion
    max_iterations::Int
end

"""
DefaultStoppingCriterionState <: StoppingCriterionState

A [`StoppingCriterionState`](@ref) that does not require any information besides
storing the iteration number when it (last) indicated to stop).

# Field
* `at_iteration::Int` store the iteration number this state
  indicated to stop.
  * `0` means already at the start it indicated to stop
  * any negative number means that it did not yet indicate to stop.
"""
mutable struct DefaultStoppingCriterionState
    at_iteration::Int
    DefaultStoppingCriterionState() = new(-1)
end

initialize_state(::Problem, ::Algorithm, ::StopAfterIteration; kwargs...) =
    DefaultStoppingCriterionState()
function initialize_state!(
    scs::DefaultStoppingCriterionState,
    ::Problem,
    ::Algorithm,
    ::StopAfterIteration;
    kwargs...,
)
    scs.at_iteration = -1
    return scs
end

function (scs::DefaultStoppingCriterionState)(
    ::Problem,
    ::Algorithm,
    s::State,
    sc::StopAfterIteration,
)
    k = get_iteration(s)
    (k == 0) && (scs.at_iteration = -1)
    if k >= sc.max_iterations
        scs.at_iteration = k
        return true
    end
    return false
end
function get_reason(sc::StopAfterIteration, scs::DefaultStoppingCriterionState)
    if scs.at_iteration >= sc.max_iterations
        return "At iteration $(scs.at_iteration) the algorithm reached its maximal number of iterations ($(sc.max_iterations)).\n"
    end
    return ""
end
indicates_convergence(sc::StopAfterIteration) = false
function get_summary(sc::StopAfterIteration, scs::DefaultStoppingCriterionState)
    has_stopped = (scs.at_iteration >= 0)
    s = has_stopped ? "reached" : "not reached"
    return "Max Iteration $(sc.max_iterations):\t$s"
end

"""
    StopAfter <: StoppingCriterion

store a threshold when to stop looking at the complete runtime. It uses
`time_ns()` to measure the time and you provide a `Period` as a time limit,
for example `Minute(15)`.

# Fields

* `threshold` stores the `Period` after which to stop

# Constructor

    StopAfter(t)

initialize the stopping criterion to a `Period t` to stop after.
"""
struct StopAfter <: StoppingCriterion
    threshold::Period
    function StopAfter(t::Period)
        if value(t) < 0
            error("You must provide a positive time period")
        else
            s = new(t)
        end
        return s
    end
end

@doc """
    StopAfterTimePeriodState <: StoppingCriterionState

A state for stopping criteria that are based on time measurements,
for example [`StopAfter`](@ref).

* `start` stores the starting time when the algorithm is started, that is a call with `i=0`.
* `time` stores the elapsed time
* `at_iteration` indicates at which iteration (including `i=0`) the stopping criterion
  was fulfilled and is `-1` while it is not fulfilled.

"""
mutable struct StopAfterTimePeriodState <: StoppingCriterionState
    start::Nanosecond
    time::Nanosecond
    at_iteration::Int
    function StopAfterTimePeriodState()
        return new(Nanosecond(0), Nanosecond(0), -1)
    end
end

initialize_state(::Problem, ::Algorithm, ::StopAfter; kwargs...) =
    StopAfterTimePeriodState()

function initialize_state!(
    scs::DefaultStoppingCriterionState,
    ::Problem,
    ::Algorithm,
    ::StopAfter;
    kwargs...,
)
    scs.start = Nanosecond(0)
    scs.time = Nanosecond(0)
    scs.at_iteration = -1
    return scs
end

function (scs::StopAfterTimePeriodState)(::Problem, ::Algorithm, s::State, sc::StopAfter)
    k = get_iteration(s)
    if value(scs.start) == 0 || k <= 0 # (re)start timer
        scs.at_iteration = -1
        scs.start = Nanosecond(time_ns())
        scs.time = Nanosecond(0)
    else
        scs.time = Nanosecond(time_ns()) - scs.start
        if k > 0 && (scs.time > Nanosecond(sc.threshold))
            scs.at_iteration = k
            return true
        end
    end
    return false
end
function get_reason(sc::StopAfter, scs::StopAfterTimePeriodState)
    if (scs.at_iteration >= 0)
        return "After iteration $(scs.at_iteration) the algorithm ran for $(floor(scs.time, typeof(sc.threshold))) (threshold: $(sc.threshold)).\n"
    end
    return ""
end
function get_summary(sc::StopAfter, scs::StopAfterTimePeriodState)
    has_stopped = (scs.at_iteration >= 0)
    s = has_stopped ? "reached" : "not reached"
    return "stopped after $(sc.threshold):\t$s"
end
indicates_convergence(sc::StopAfter) = false
