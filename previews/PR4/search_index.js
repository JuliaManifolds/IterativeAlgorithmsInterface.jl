var documenterSearchIndex = {"docs":
[{"location":"references/#Literature","page":"References","title":"Literature","text":"","category":"section"},{"location":"references/","page":"References","title":"References","text":"This is all literature mentioned / referenced in the AlgorithmsInterface.jl documentation. Usually you find a small reference section at the end of every documentation page that contains the corresponding references as well.","category":"page"},{"location":"references/","page":"References","title":"References","text":"","category":"page"},{"location":"interface/#The-algorithm-interface","page":"Interface","title":"The algorithm interface","text":"","category":"section"},{"location":"interface/#General-design-ideas","page":"Interface","title":"General design ideas","text":"","category":"section"},{"location":"interface/","page":"Interface","title":"Interface","text":"The interface this package provides is based on three ingredients of running an algorithm consists of:","category":"page"},{"location":"interface/","page":"Interface","title":"Interface","text":"a Problem that is to be solved and contains all information that is algorithm independent. This is static information in the sense that it does not change during the runtime of the algorithm\nan Algorithm that includes all of the settings and parameters that an algorithm. this is also information that is static\na State that contains all remaining data, especially data that might vary during the iteration, temporary caches, for example the current iteration the algorithm run is in and the current iterate, respectively.","category":"page"},{"location":"interface/","page":"Interface","title":"Interface","text":"The combination of the static information should be enough to initialize the varying data.","category":"page"},{"location":"interface/","page":"Interface","title":"Interface","text":"This general scheme is a guiding principle of the package, splitting information into static or configuration types or data that allows to initialize_state a correspondint variable data type.","category":"page"},{"location":"interface/","page":"Interface","title":"Interface","text":"The order of arguments is given by two ideas","category":"page"},{"location":"interface/","page":"Interface","title":"Interface","text":"for non-mutating functions the order should be from the most fixed data to the most variable one.","category":"page"},{"location":"interface/","page":"Interface","title":"Interface","text":"For example the three types just mentioned would be ordered like f(problem, algorithm, state)","category":"page"},{"location":"interface/","page":"Interface","title":"Interface","text":"For mutating functions the variable that is mutated comes first, for the remainder the guiding principle from 1 continues.","category":"page"},{"location":"interface/","page":"Interface","title":"Interface","text":"The main case here is f!(state, problem, algorithm).","category":"page"},{"location":"interface/","page":"Interface","title":"Interface","text":"Modules = [AlgorithmsInterface]\nPages = [\"interface/interface.jl\"]\nOrder = [:type, :function]\nPrivate = true","category":"page"},{"location":"interface/#AlgorithmsInterface.initialize_state!-Tuple{State, Problem, Algorithm}","page":"Interface","title":"AlgorithmsInterface.initialize_state!","text":"s = initialize_state(p::Problem, a::Algorithm; kwargs...)\ninitialize_state!(s::State, p::Problem, a::Algorithm; kwargs...)\n\nInitialize a State s base on a Problem p and an Algorithm. The kwargs... should allow to initialize for example the initial point. This can be done in-place of s, then only values that did change have to be provided.\n\n\n\n\n\n","category":"method"},{"location":"interface/#AlgorithmsInterface.initialize_state-Tuple{Problem, Algorithm}","page":"Interface","title":"AlgorithmsInterface.initialize_state","text":"s = initialize_state(p::Problem, a::Algorithm; kwargs...)\ninitialize_state!(s::State, p::Problem, a::Algorithm; kwargs...)\n\nInitialize a State s base on a Problem p and an Algorithm. The kwargs... should allow to initialize for example the initial point. This can be done in-place of s, then only values that did change have to be provided.\n\n\n\n\n\n","category":"method"},{"location":"interface/#AlgorithmsInterface.is_finished-Tuple{Problem, Algorithm, State}","page":"Interface","title":"AlgorithmsInterface.is_finished","text":"is_finished(p::Problem, a::Algorithm, s::State)\n\nReturn true if the Algorithm a solving the Problem p with current State s is finished\n\n\n\n\n\n","category":"method"},{"location":"interface/#AlgorithmsInterface.solve!-Tuple{State, Problem, Algorithm}","page":"Interface","title":"AlgorithmsInterface.solve!","text":"solve!(p::Problem, a::Algorithm, s::State; kwargs...)\n\nSolve the Problem p using the Algorithm a modifying on the State.\n\nAll keyword arguments are passed to the initialize_state!(s, p, a) function.\n\n\n\n\n\n","category":"method"},{"location":"interface/#AlgorithmsInterface.solve-Tuple{Problem, Algorithm}","page":"Interface","title":"AlgorithmsInterface.solve","text":"solve(p::Problem, a::Algorithm; kwargs...)\n\nSolve the Problem p using the Algorithm a. The keyword arguments kwargs... have to provide enough details such that the corresponding state initialisation initialize_state(p,a) returns a state.\n\nBy default this method continues to call solve!.\n\n\n\n\n\n","category":"method"},{"location":"interface/#AlgorithmsInterface.step!-Tuple{State, Problem, Algorithm}","page":"Interface","title":"AlgorithmsInterface.step!","text":"step!(s::State, p::Problem, a::Algorithm)\n\nPerform the current step of an Algorithm a solving Problem p modifying the algorithms State s.\n\n\n\n\n\n","category":"method"},{"location":"interface/#Algorithm","page":"Interface","title":"Algorithm","text":"","category":"section"},{"location":"interface/","page":"Interface","title":"Interface","text":"Modules = [AlgorithmsInterface]\nPages = [\"interface/algorithm.jl\"]\nOrder = [:type, :function]\nPrivate = true","category":"page"},{"location":"interface/#AlgorithmsInterface.Algorithm","page":"Interface","title":"AlgorithmsInterface.Algorithm","text":"Algorithm\n\nAn abstract type to represent an algorithm.\n\nA concrete algorithm contains all static parameters that characterise the algorithms. Together with a Problem an Algorithm subtype should be able to initialize or reset a State.\n\nUsual fields\n\nUsually this should include the following. If you use this naming scheme, default functions e.g. as accessors\n\nstopping_criterion a StoppingCriterion\n\nMethods\n\nThe following methods should be implemented for an Algorithm\n\nget_stopping_criterion to return the algorithms stopping criterion.\n\nExample\n\nFor a gradient descent algorithm the algorithm would specify which step size selection to use.\n\n\n\n\n\n","category":"type"},{"location":"interface/#AlgorithmsInterface.get_stopping_criterion-Tuple{Algorithm}","page":"Interface","title":"AlgorithmsInterface.get_stopping_criterion","text":"get_stopping_criterion(a::Algorithm)\n\nReturn the StoppingCriterion of the Algorithm a.\n\nThe default assumes that the criterion is stored in s.stopping_criterion_state.\n\n\n\n\n\n","category":"method"},{"location":"interface/#Problem","page":"Interface","title":"Problem","text":"","category":"section"},{"location":"interface/","page":"Interface","title":"Interface","text":"Modules = [AlgorithmsInterface]\nPages = [\"interface/problem.jl\"]\nOrder = [:type, :function]\nPrivate = true","category":"page"},{"location":"interface/#AlgorithmsInterface.Problem","page":"Interface","title":"AlgorithmsInterface.Problem","text":"Problem\n\nAn abstract type to represent a problem to be solved with all its static properties, that do not change during an algorithm run.\n\nExample\n\nFor a gradient descent algorithm the problem consists of\n\na cost function f C  ℝ\na gradient function operatornamegradf\n\nThe problem then could that these are given in four different forms\n\na function c = cost(x) and a gradient d = gradient(x)\na function c = cost(x) and an in-place gradient gradient!(d,x)\na combined cost-grad function (c,d) = costgrad(x)\na combined cost-grad function (c, d) = costgrad!(d, x) that computes the gradient in-place.\n\n\n\n\n\n","category":"type"},{"location":"interface/#State","page":"Interface","title":"State","text":"","category":"section"},{"location":"interface/","page":"Interface","title":"Interface","text":"Modules = [AlgorithmsInterface]\nPages = [\"interface/state.jl\"]\nOrder = [:type, :function]\nPrivate = true","category":"page"},{"location":"interface/#AlgorithmsInterface.State","page":"Interface","title":"AlgorithmsInterface.State","text":"State\n\nAn abstract type to represent the state an iterative algorithm is in.\n\nThe state consists of any information that describes the current step the algorithm is in and keeps all information needed from one step to the next.\n\nUsual fields\n\nUsually this should include the following. If you use this naming scheme, default functions e.g. as accessors\n\niteration – the current iteration step k that is is currently performed or was last performed\nstopping_criterion_state – a StoppingCriterionState that indicates whether an Algorithm will stop after this iteration or has stopped.\niterate the current iterate x^(k)`.\n\nThese variable names given in this list are the defaults for which the accessors are implemented, such that if your concrete MyState <: State follows this convention, you do not have to reimplement their accessors.\n\nMethods\n\nThe following methods should be implemented for a state\n\nget_iteration(s) to return the current iteration number\n`increment!(s)\nget_stopping_criterion_state return the StoppingCriterionState\nget_iterate return the current iterate x^(k).\n\n\n\n\n\n","category":"type"},{"location":"interface/#AlgorithmsInterface.get_iterate-Tuple{State}","page":"Interface","title":"AlgorithmsInterface.get_iterate","text":"get_iterate(s::State)\n\nReturn the current iterate x^(k) of a State s\n\nThe default assumes that the current iteration is stored in s.iterate.\n\n\n\n\n\n","category":"method"},{"location":"interface/#AlgorithmsInterface.get_iteration-Tuple{State}","page":"Interface","title":"AlgorithmsInterface.get_iteration","text":"get_iteration(s::State)\n\nReturn the current iteration a State s either is currently performing or was last performed\n\nThe default assumes that the current iteration is stored in s.iteration.\n\n\n\n\n\n","category":"method"},{"location":"interface/#AlgorithmsInterface.get_stopping_criterion_state-Tuple{State}","page":"Interface","title":"AlgorithmsInterface.get_stopping_criterion_state","text":"get_stopping_criterion_state(s::State)\n\nReturn the StoppingCriterionState of the State s.\n\nThe default assumes that the criterion is stored in s.stopping_criterion_state.\n\n\n\n\n\n","category":"method"},{"location":"interface/#AlgorithmsInterface.increment!-Tuple{State}","page":"Interface","title":"AlgorithmsInterface.increment!","text":"increment!(s::State)\n\nReturn the current iteration a State s either is currently performing or was last performed\n\nThe default assumes that the current iteration is stored in s.iteration.\n\n\n\n\n\n","category":"method"},{"location":"stopping_criterion/#Stopping-criterion","page":"Stopping criteria","title":"Stopping criterion","text":"","category":"section"},{"location":"stopping_criterion/","page":"Stopping criteria","title":"Stopping criteria","text":"Modules = [AlgorithmsInterface]\nPages = [\"stopping_criterion.jl\"]\nOrder = [:type, :function]\nPrivate = true","category":"page"},{"location":"stopping_criterion/#AlgorithmsInterface.DefaultStoppingCriterionState","page":"Stopping criteria","title":"AlgorithmsInterface.DefaultStoppingCriterionState","text":"DefaultStoppingCriterionState <: StoppingCriterionState\n\nA StoppingCriterionState that does not require any information besides storing the iteration number when it (last) indicated to stop).\n\nField\n\nat_iteration::Int store the iteration number this state indicated to stop.\n0 means already at the start it indicated to stop\nany negative number means that it did not yet indicate to stop.\n\n\n\n\n\n","category":"type"},{"location":"stopping_criterion/#AlgorithmsInterface.GroupStoppingCriterionState","page":"Stopping criteria","title":"AlgorithmsInterface.GroupStoppingCriterionState","text":"GroupStoppingCriterionState <: StoppingCriterionState\n\nA StoppingCriterionState that groups multiple StoppingCriterionStates internally as a tuple. This is for example used in combination with StopWhenAny and StopWhenAny\n\nConstructor\n\nGroupStoppingCriterionState(c::Vector{N,StoppingCriterionState} where N)\nGroupStoppingCriterionState(c::StoppingCriterionState...)\n\n\n\n\n\n","category":"type"},{"location":"stopping_criterion/#AlgorithmsInterface.StopAfter","page":"Stopping criteria","title":"AlgorithmsInterface.StopAfter","text":"StopAfter <: StoppingCriterion\n\nstore a threshold when to stop looking at the complete runtime. It uses time_ns() to measure the time and you provide a Period as a time limit, for example Minute(15).\n\nFields\n\nthreshold stores the Period after which to stop\n\nConstructor\n\nStopAfter(t)\n\ninitialize the stopping criterion to a Period t to stop after.\n\n\n\n\n\n","category":"type"},{"location":"stopping_criterion/#AlgorithmsInterface.StopAfterIteration","page":"Stopping criteria","title":"AlgorithmsInterface.StopAfterIteration","text":"StopAfterIteration <: StoppingCriterion\n\nA simple stopping criterion to stop after a maximal number of iterations.\n\nFields\n\nmax_iterations  stores the maximal iteration number where to stop at\n\nConstructor\n\nStopAfterIteration(maxIter)\n\ninitialize the functor to indicate to stop after maxIter iterations.\n\n\n\n\n\n","category":"type"},{"location":"stopping_criterion/#AlgorithmsInterface.StopAfterTimePeriodState","page":"Stopping criteria","title":"AlgorithmsInterface.StopAfterTimePeriodState","text":"StopAfterTimePeriodState <: StoppingCriterionState\n\nA state for stopping criteria that are based on time measurements, for example StopAfter.\n\nstart stores the starting time when the algorithm is started, that is a call with i=0.\ntime stores the elapsed time\nat_iteration indicates at which iteration (including i=0) the stopping criterion was fulfilled and is -1 while it is not fulfilled.\n\n\n\n\n\n","category":"type"},{"location":"stopping_criterion/#AlgorithmsInterface.StopWhenAll","page":"Stopping criteria","title":"AlgorithmsInterface.StopWhenAll","text":"StopWhenAll <: StoppingCriterion\n\nstore a tuple of StoppingCriterions and indicate to stop, when all indicate to stop.\n\nConstructor\n\nStopWhenAll(c::NTuple{N,StoppingCriterion} where N)\nStopWhenAll(c::StoppingCriterion,...)\n\n\n\n\n\n","category":"type"},{"location":"stopping_criterion/#AlgorithmsInterface.StopWhenAny","page":"Stopping criteria","title":"AlgorithmsInterface.StopWhenAny","text":"StopWhenAny <: StoppingCriterion\n\nstore an array of StoppingCriterion elements and indicates to stop, when any single one indicates to stop. The reason is given by the concatenation of all reasons (assuming that all non-indicating return \"\").\n\nConstructors\n\nStopWhenAny(c::Vector{N,StoppingCriterion} where N)\nStopWhenAny(c::StoppingCriterion...)\n\n\n\n\n\n","category":"type"},{"location":"stopping_criterion/#AlgorithmsInterface.StoppingCriterion","page":"Stopping criteria","title":"AlgorithmsInterface.StoppingCriterion","text":"StoppingCriterion\n\nAn abstract type to represent a stopping criterion.\n\nA concrete StoppingCriterion sc should also implement a initialize_state(problem::Problem, algorithm::Algorithm, sc::StoppingCriterion; kwargs...) function to create its accompanying StoppingCriterionState. as well as the corresponting mutating variant to reset such a StoppingCriterionState.\n\nIt should usually implement\n\nindicates_convergence(sc) a boolean whether or not this stopping criterion would indicate that the algorithm has converged, if it indicates to stop.\n\n\n\n\n\n","category":"type"},{"location":"stopping_criterion/#AlgorithmsInterface.StoppingCriterionState","page":"Stopping criteria","title":"AlgorithmsInterface.StoppingCriterionState","text":"StoppingCriterionState\n\nAn abstract type to represent a stopping criterion state withinn a State.\n\nAny concrete stopping criterion should be implemented as a functor, that takes the “usual tuple” (problem, algorithm, state, stopping_criterion) of a Problem p, an Algorithm and a State as input, as well as the corresponding StoppingCriterion. Though this is usually stored¨ in the Algorithm algorithm, the extra parameter allows both for more flexibility and for multiple dispatch. The concrete StoppingCriterionState should be part of the State state.\n\nThe functor might modify the stopping criterion state.\n\n\n\n\n\n","category":"type"},{"location":"stopping_criterion/#AlgorithmsInterface.get_reason-Tuple{StoppingCriterion, StoppingCriterionState}","page":"Stopping criteria","title":"AlgorithmsInterface.get_reason","text":"get_reason(sc::StoppingCriterion, scs::StoppingCriterionState)\n\nProvide a reason in human readable text as to why a StoppingCriterion sc with [StoppingCriterionState](@ref)scs` indicated to stop. If it does not indicate to stop, this should return an empty string.\n\nProviding the iteration at which this indicated to stop in the reason would be preferable.\n\n\n\n\n\n","category":"method"},{"location":"stopping_criterion/#AlgorithmsInterface.indicates_convergence-Tuple{StoppingCriterion, StoppingCriterionState}","page":"Stopping criteria","title":"AlgorithmsInterface.indicates_convergence","text":"indicates_convergence(sc::StoppingCriterion, ::StoppingCriterionState)\n\nReturn whether or not a StoppingCriterion sc indicates convergence when it is in StoppingCriterionState\n\nBy default this checks whether the StoppingCriterion has actually stopped. If so it returns whether sc itself indicates convergence, otherwise it returns false, since the algorithm has then not yet stopped.\n\n\n\n\n\n","category":"method"},{"location":"stopping_criterion/#AlgorithmsInterface.indicates_convergence-Tuple{StoppingCriterion}","page":"Stopping criteria","title":"AlgorithmsInterface.indicates_convergence","text":"indicates_convergence(sc::StoppingCriterion)\n\nReturn whether or not a StoppingCriterion sc indicates convergence.\n\n\n\n\n\n","category":"method"},{"location":"stopping_criterion/#AlgorithmsInterface.summary-Tuple{StoppingCriterion, StoppingCriterionState}","page":"Stopping criteria","title":"AlgorithmsInterface.summary","text":"summary(sc::StoppingCriterion, scs::StoppingCriterionState)\n\nProvide a summary of the status of a stopping criterion – its parameters and whether it currently indicates to stop. It should not be longer than one line\n\nExample\n\nFor the StopAfterIteration criterion, the summary looks like\n\nMax Iterations (15): not reached\n\n\n\n\n\n","category":"method"},{"location":"stopping_criterion/#Base.:&-Tuple{StoppingCriterion, StoppingCriterion}","page":"Stopping criteria","title":"Base.:&","text":"&(s1,s2)\ns1 & s2\n\nCombine two StoppingCriterion within an StopWhenAll. If either s1 (or s2) is already an StopWhenAll, then s2 (or s1) is appended to the list of StoppingCriterion within s1 (or s2).\n\nExample\n\na = StopAfterIteration(200) & StopAfter(Minute(1))\n\nIs the same as\n\na = StopWhenAll(StopAfterIteration(200), StopAfter(Minute(1))\n\n\n\n\n\n","category":"method"},{"location":"stopping_criterion/#Base.:|-Tuple{StoppingCriterion, StoppingCriterion}","page":"Stopping criteria","title":"Base.:|","text":"|(s1,s2)\ns1 | s2\n\nCombine two StoppingCriterion within an StopWhenAny. If either s1 (or s2) is already an StopWhenAny, then s2 (or s1) is appended to the list of StoppingCriterion within s1 (or s2)\n\nExample\n\na = StopAfterIteration(200) | StopAfter(Minute(1))\n\nIs the same as\n\na = StopWhenAny(StopAfterIteration(200), StopAfter(Minute(1)))\n\n\n\n\n\n","category":"method"},{"location":"#AlgorithmsInterface.jl","page":"Home","title":"AlgorithmsInterface.jl","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Welcome to the Documentation of LieGAlgorithmsInterface.jl.","category":"page"},{"location":"","page":"Home","title":"Home","text":"CurrentModule = AlgorithmsInterface","category":"page"},{"location":"","page":"Home","title":"Home","text":"AlgorithmsInterface.AlgorithmsInterface","category":"page"},{"location":"#AlgorithmsInterface.AlgorithmsInterface","page":"Home","title":"AlgorithmsInterface.AlgorithmsInterface","text":"🧮 AlgorithmsInterface.jl: an interface for iterative algorithms in Julia\n\n📚 Documentation: juliamanifolds.github.io/AlgorithmsInterface.jl/\n📦 Repository: github.com/JuliaManifolds/AlgorithmsInterface.jl\n💬 Discussions: github.com/JuliaManifolds/AlgorithmsInterface.jl/discussions\n🎯 Issues: github.com/JuliaManifolds/AlgorithmsInterface.jl/issues\n\n\n\n\n\n","category":"module"},{"location":"notation/#Notation","page":"Notation","title":"Notation","text":"","category":"section"},{"location":"notation/","page":"Notation","title":"Notation","text":"Throughout the package we use the following abbreviations and variable names, where the longer names are usually used in the documentation and as keywords. The shorter ones are often used in code when their name does not cause ambiguities.","category":"page"},{"location":"notation/","page":"Notation","title":"Notation","text":"Name Variable Comment\nAlgorithm algorithm, a \nProblem problem, p \nState state, s \nStoppingCriterion stopping_criterion, sc \nStoppingCriterionState stopping_criterion_state, scs ","category":"page"}]
}
