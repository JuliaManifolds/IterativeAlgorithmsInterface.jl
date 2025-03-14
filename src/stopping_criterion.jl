@doc """
    StoppingCriterion

An abstract type to represent a stopping criterion of an solver.

Any concrete stopping criterion should be implemented as a functor,
that takes the “usual tuple” `(p, a, s)` of a [`Problem`](@ref),
an [`algorithm`](@ref) and a [`State`](@ref) as input

## Methods
A concrete `StoppingCriterion` `sc` should provide the following functions
besides the above-mentioned functor is it itself

* `get_reason(sc)` a human readable text of about one line of length providing a reason
  why this stopping criterion indicated to stop. An empty string if it did not indicate to stop
* `status_summary(sc)` a short summary of this stopping criterion, and whether it was reached,
  e.g. a short string like `"Max Iterations (15): reached"`
* `indicates_convergence(sc)` a boolean whether or not this stopping criterion would indicate
  that the algorithm has converged, if it indicates to stop.
* `show(io::IO, sc)` to display its constructor and the `status_summary`
"""
abstract type StoppingCriterion end

@doc raw"""
    StopAfterIteration <: StoppingCriterion

A functor for a stopping criterion to stop after a maximal number of iterations.

# Fields

* `max_iterations`  stores the maximal iteration number where to stop at
* `at_iteration` indicates at which iteration (including `i=0`) the stopping criterion
  was fulfilled and is `-1` while it is not fulfilled.

# Constructor

    StopAfterIteration(maxIter)

initialize the functor to indicate to stop after `maxIter` iterations.
"""
mutable struct StopAfterIteration <: StoppingCriterion
    max_iterations::Int
    at_iteration::Int
    StopAfterIteration(k::Int) = new(k, -1)
end
function (sc::StopAfterIteration)(::Problem, ::Algorithm, s::State)
    k = get_iteration(s)
    if k == 0 # reset on init
        sc.at_iteration = -1
    end
    if k >= sc.max_iterations
        sc.at_iteration = k
        return true
    end
    return false
end
function get_reason(c::StopAfterIteration)
    if c.at_iteration >= c.max_iterations
        return "At iteration $(c.at_iteration) the algorithm reached its maximal number of iterations ($(c.max_iterations)).\n"
    end
    return ""
end
indicates_convergence(sc::StopAfterIteration) = false
function status_summary(c::StopAfterIteration)
    has_stopped = (c.at_iteration >= 0)
    s = has_stopped ? "reached" : "not reached"
    return "Max Iteration $(c.max_iterations):\t$s"
end
function show(io::IO, c::StopAfterIteration)
    return print(io, "StopAfterIteration($(c.max_iterations))\n    $(status_summary(c))")
end

"""
    StopAfter <: StoppingCriterion

store a threshold when to stop looking at the complete runtime. It uses
`time_ns()` to measure the time and you provide a `Period` as a time limit,
for example `Minute(15)`.

# Fields

* `threshold` stores the `Period` after which to stop
* `start` stores the starting time when the algorithm is started, that is a call with `i=0`.
* `time` stores the elapsed time
* `at_iteration` indicates at which iteration (including `i=0`) the stopping criterion
  was fulfilled and is `-1` while it is not fulfilled.

# Constructor

    StopAfter(t)

initialize the stopping criterion to a `Period t` to stop after.
"""
mutable struct StopAfter <: StoppingCriterion
    threshold::Period
    start::Nanosecond
    time::Nanosecond
    at_iteration::Int
    function StopAfter(t::Period)
        return if value(t) < 0
            error("You must provide a positive time period")
        else
            new(t, Nanosecond(0), Nanosecond(0), -1)
        end
    end
end
function (sc::StopAfter)(::Problem, ::Algorithm, s::State)
    k = get_iteration(s)
    if value(sc.start) == 0 || k <= 0 # (re)start timer
        sc.at_iteration = -1
        sc.start = Nanosecond(time_ns())
        sc.time = Nanosecond(0)
    else
        sc.time = Nanosecond(time_ns()) - sc.start
        if k > 0 && (sc.time > Nanosecond(sc.threshold))
            sc.at_iteration = k
            return true
        end
    end
    return false
end
function get_reason(sc::StopAfter)
    if (c.at_iteration >= 0)
        return "After iteration $(sc.at_iteration) the algorithm ran for $(floor(c.time, typeof(c.threshold))) (threshold: $(c.threshold)).\n"
    end
    return ""
end
function status_summary(c::StopAfter)
    has_stopped = (c.at_iteration >= 0)
    s = has_stopped ? "reached" : "not reached"
    return "stopped after $(c.threshold):\t$s"
end
indicates_convergence(c::StopAfter) = false
function show(io::IO, sc::StopAfter)
    return print(io, "StopAfter($(repr(sc.threshold)))\n    $(status_summary(sc))")
end