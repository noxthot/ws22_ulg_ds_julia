@def title = "Performance"
@def hascode = true

@def tags = ["Parallel Computing", "Performance"]

# How to measure performance in Julia

For that, we recall the vector summation example from the introduction to [function](../../introduction/functions/) and include the simple `@time` macro.
```julia:./code/performance.jl
function mysum(V)
    s = zero(eltype(V))

    for i in eachindex(V)
        @inbounds s += V[i]
    end

    return s
end

V = rand(100_000)
@time mysum(V)
@time mysum(V)
```
\show{./code/performance.jl}

@@important
In order to optimize the loop call we use the [`@inbounds`](https://docs.julialang.org/en/v1/devdocs/boundscheck/) macro to eliminate inbound checks - does the index exist - for the array access.
**Note** that this macro is potentially very dangerous since the program will silently fail if we try to index into a smaller array.
@@

The downside with the `@time` macro is, that it really just measures the execution time of what is given to it. This means, if the function is not already compiled this might include compiling or if the CPU is busy with something else it is often not accurate. 

Therefore, if we are serious about measuring performance we should stick to the [`BenchmarkTools`](https://juliaci.github.io/BenchmarkTools.jl/stable/). It comes with a couple of macros that we should test out:

\exercise{
In order to use the BenchmarkTools we need to include it with `using BenchmarkTools`, as any other package. 
Benchmark our `mysum` function with the following macros:
1. `@benchmark`
2. `@btime` 
3. Look at the detailed output of your benchmark with `dump(t)`, where `t` is the output result of a `@benchmark` run.
and compare the output and results.
\solution{
To measure the performance of the above code we do the following:
```julia:./code/performance.jl
using BenchmarkTools

@benchmark mysum($V)
```
\show{./code/performance.jl}
the full details with 
```julia:./code/performance.jl
t = @benchmark mysum($V)
dump(t)
```
\show{./code/performance.jl}
and the often used sanity check, that actually also shows you the output of your code.
```julia:./code/performance.jl
@btime mysum($V)
```
\show{./code/performance.jl}
}
}

@@important
Note that for benchmarking with BenchmarkTools we often use the `$` literal for variables to tell the Julia interpreter to use interpolation. 
This will make sure that the variable is not allocated inside the function and the measurement is more accurate, or more likely what we actually want to know. 
@@ 

We can also use the [`Profiler`](https://docs.julialang.org/en/v1/manual/profile/#Profiling) package to really dig into profiling the code but this is a bit too much of a deep dive for this class.

One should also take a look at the [performance tips](https://docs.julialang.org/en/v1/manual/performance-tips/) section of the manual.
Especially the parts about avoiding untyped global variables and putting code inside functions are sometimes very performance critical.

# Performance Optimization - Case Study

We give an example of how one can optimize the code of a simple program. The goal is to calculate pairwise distances of 3D points and save the results inside a matrix.
That is given $x\in\mathbb{R}^{3\times N}, y\in\mathbb{R}^{3\times M}$ we want to calculate $z_{i,j} = \Vert x_i - y_j \Vert_2^2$. for $i=1,\ldots,N, \; j=1,\ldots,M$.

First we have a simple one-liner
```julia:./code/performance-sample.jl
calc1(x, y) = [norm(x[:,i] - y[:,j])^2 for i in 1:size(x, 2), j in 1:size(y, 2)]
```

A first improvement can be achieved by preallocation the result and using views since accessing slices in julia always performs a copy and therefore allocates.

```julia:./code/performance-sample.jl
function calc2!(z::Matrix{T}, x::Matrix{T}, y::Matrix{T}) where {T<:AbstractFloat}
    # check dimensions since we later use `@inbounds`
    @assert size(x, 1) == size(y, 1)
    @assert size(z) == (size(x, 2), size(y, 2))

    for j in axes(z, 2), i in axes(z, 1)
        # allocates 2 times
        # 1 from - and 1 from .^
        @inbounds @views z[i,j] = sum((x[:, i] - y[:, j]).^2)
    end
    return z
end
```

```julia:./code/performance-sample.jl
function calc3!(z::Matrix{T}, x::Matrix{T}, y::Matrix{T}) where {T<:AbstractFloat}
    @assert size(x, 1) == size(y, 1)
    @assert size(z) == (size(x, 2), size(y, 2))

    for j in axes(z, 2), i in axes(z, 1)
        for k in 1:size(x, 1)
            @inbounds z[i,j] += (x[k, i] - y[k, j])^2
        end
    end
    return z
end
```

```julia:./code/performance-sample.jl
using Base.Threads

function calc4!(z::Matrix{T}, x::Matrix{T}, y::Matrix{T}) where {T<:AbstractFloat}
    @assert size(x, 1) == size(y, 1)
    @assert size(z) == (size(x, 2), size(y, 2))

    @threads for j in axes(z, 2)
        for i in axes(z, 1)
            for k in 1:size(x, 1)
                @inbounds z[i,j] += (x[k, i] - y[k, j])^2
            end
        end
    end
    return z
end
```

```julia:./code/performance-sample.jl
using BenchmarkTools, LinearAlgebra, Test

@testset begin
    x, y = rand(3, 10), rand(3, 5)
    ref = calc1(x, y)
    for f in [calc2!, calc3!, calc4!]
        out = zeros(size(ref))
        f(out, x, y)
        @test ref ≈ out
    end
end

# Time code
x, y = rand(3, 100), rand(3, 200)
z = zeros(size(x, 2), size(y, 2))

println("\nUsing $(nthreads()) threads\n")

@btime calc1(x, y)
@btime calc2!(z, x, y)
@btime calc3!(z, x, y)
@btime calc4!(z, x, y);
```
\show{./code/performance-sample.jl}
