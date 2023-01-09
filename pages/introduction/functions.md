@def title = "Functions"
@def hascode = true

@def tags = ["introduction"]

# Functions

\toc


## Syntax
To improve the structure and ensure reusability of pieces of our program we can use the `function` command. We have already used functions when, for example, calling `typeof(input)`. Other examples of functions that can be found on any common calculators are `sin(x)` or `exp(x)`. The syntax to define our own functions is the following:
```julia
function foo(input)
    # function body that is executed when foo is called

    return output
end
```
So if we want to define a function which prints out and returns $\sin(\cos(x))$ we can write
```julia
function sincos(x)
    result = sin(cos(x))
    println("sin(cos($x)) = $result")
    
    return result
end
```
If we wish to specify multiple inputs and outputs we can do so as well:
```julia
function sincos(x, y)
    result1 = sin(cos(x))
    result2 = sin(cos(y))
    
    println("sin(cos($x)) = $result1")
    println("sin(cos($y)) = $result2")
    
    return result1, result2
end
```
We can call a function with multiple outputs via `out = foo(input)` and access the output at index $i$ through `out[i]`. We can also write (assuming two outputs) `out1, out2 = foo(input)` and `out1, _ = foo(input)` if we only need one of the outputs.
The above functions actually returns a tuple `(result1, result2)`.
```julia-repl
julia> x = 1; y = 1.5;
julia> res1, res2 = sincos(x, y)
sin(cos(1)) = 0.5143952585235492
sin(cos(1.5)) = 0.07067822452613834
(0.5143952585235492, 0.07067822452613834)

julia> res1
0.5143952585235492

julia> res = sincos(x, y);

julia> res[1]
0.5143952585235492
```
Note that in julia function names are not constant i.e. it is possible to redefine a function mutliple times and when calling it the most recent version is used.
This also holds true for function included in julia itself e.g. `sincos` already exists and by doing the above one can no longer directly call it.

Let us practice this syntax by revisiting loops:

\exercise{
For a vector $V\in\mathrm{R}^n$ with elements $v_1, \ldots, v_n$ compute the mean of all the elements in the following fashion

1. Sum over the elements per index:
   $$m = \frac{1}{n}\sum_{i=1}^n v_i$$
2. Transform this loop into a function `mymean`
3. Test against `V = rand(100_000)` and `mymean(V) ≈ mean(V)` (use `\approx + TAB` for ≈) using the `Statistics` standard library

\solution{

```julia
function mymean(V)
    s = zero(eltype(V))

    for i in eachindex(V)
        s += V[i]
    end

    return s / length(V)
end

using Statistics
V = rand(100_000)
mymean(V) ≈ mean(V)
```

}
}


## Anonymous functions
Functions can also be created anonymously, that is, without giving a name. We call these functions [*anonymous functions*](https://docs.julialang.org/en/v1/manual/functions/#man-anonymous-functions) and they are especially feasible when we want to use a function as an argument. The following snippet creates an anonymous function that takes one argument `x` and returns $x^2 + 1$:
```julia-repl
julia> x -> x^2 + 1
#1 (generic function with 1 method)
```

Unfortunately, this function can not be accessed again, since we do not have a name/variable which could be accessed. But we can apply a value right away and e.g. evaluate this anonymous function for $x = 3$:
```julia-repl
julia> (x -> x^2 + 1)(3)
10
```

This is not a good application for an anonymous function but there are applications where they are indeed quite helpful. Throughout this workshop, we will occasionally use anonymous functions as function arguments. Let us take a look at the function [`map(f, c)`](https://docs.julialang.org/en/v1/base/collections/#Base.map) that allows us to transform a collection (e.g. a vector) `c` by applying function `f` to every element. The following example applies $x \mapsto x^2 + 1$ to every element of the vector `[1, 2, 3, 4, 5]`:
```julia-repl
julia> map(x -> x^2 + 1, [1, 2, 3, 4, 5])
5-element Vector{Int64}:
  2
  5
 10
 17
 26
```


## Call by reference
Julia functions do not copy the input but directly operate on the input data. This means that changing values of the input in the function body will also change this data for the function caller. Whenever we define a function which will modify the input, we should indicate this with a `!` behind the function name:
```julia
function sincos!(x)
    x .= sin.(cos.(x))

    return x
end
```
Calling this function leads to
```julia-repl
julia> x = ones(2);
julia> println("Function value is ", sincos!(x))
Function value is [0.5143952585235492, 0.5143952585235492]

julia> x
2-element Vector{Float64}:
 0.5143952585235492
 0.5143952585235492
```

\exercise{

Consider two implementations
```julia
function sincos1!(x)
    x .= sin.(cos.(x))

    return x
end
```
and
```julia
function sincos2!(x)
    x = sin.(cos.(x))

    return x
end
```
1. Evaluate both functions with the input `x = ones(2)`. How does $x$ change after calling the function? Explain this behavior. Correct the function names accordingly.
2. Use the build in function `pointer(x)` to see how the memory changes and to validate your previous answer.
3. Write a method which evaluates $\sin(\cos(x))$, where $x\in\mathbb{R}$ is a scalar and stores the result on $x$ such that $x$ is modified for the caller.
\solution{
1. The function `sincos1!(x)` will modify the input:
```julia-repl
julia> x = ones(2);

julia> sincos1!(x);

julia> x
2-element Vector{Float64}:
 0.5143952585235492
 0.5143952585235492
```
The function `sincos2!(x)` will not modify the input:
```julia-repl
julia> x = ones(2);

julia> sincos2!(x);

julia> x
2-element Vector{Float64}:
 1.0
 1.0
```
The reason for this behavior is that `sincos1` changes the input as Julia functions work with call-by-reference. I.e., they do not generate a local copy of the input and instead directly work on the same memory that has been used by the caller. This memory is not reallocated due to the use of `.=`. On the other hand, `sincos2` allocates new memory, since `x = sin.(cos.(x))` will create new memory for `x` on which the values of `sin.(cos.(x))` are stored. Hence, the memory of $x$ known to the caller is not modified and the original values are preserved. Note that the name `sincos2!(x)` is hence misleading and the function should be renamed to `sincos2(x)`.
2. We have
```julia
function sincos1!(x)
    println("Address input: ", pointer(x))
    x .= sin.(cos.(x))
    println("Address output: ", pointer(x))

    return x
end
```
and
```julia
function sincos2(x)
    println("Address input: ", pointer(x))
    x = sin.(cos.(x))
    println("Address output: ", pointer(x))

    return x
end
```
Then,
```julia-repl
julia> x = ones(2);

julia> y = sincos1!(x);
Address input: Ptr{Float64} @0x00007f321c376ac0
Address output: Ptr{Float64} @0x00007f321c376ac0

julia> x = ones(2);

julia> println("Address caller: ", pointer(x));
Address caller: Ptr{Float64} @0x00007f32c1e45850

julia> y = sincos1!(x);
Address input: Ptr{Float64} @0x00007f32c1e45850
Address output: Ptr{Float64} @0x00007f32c1e45850

julia> y = sincos2(x);
Address input: Ptr{Float64} @0x00007f32c1e45850
Address output: Ptr{Float64} @0x00007f32c1e81620
```
3. This is not directly possible, since assigning a new value to a scalar $x$ will always alter the memory location.
However using `Ref` it can be done
```julia
function sincos!(x::Ref{<:Real})
    x[] = sin(cos(x[]))
end
```
and
```julia-repl
julia> x = Ref(1.2)
Base.RefValue{Float64}(1.2)

julia> sincos!(x)
0.35447986700952583

julia> x
Base.RefValue{Float64}(0.35447986700952583)

julia> x[]
0.35447986700952583
```
}
}

## Multiple dispatch
One might have observed that since we did not specify any data types, we were able to call functions using vectors and scalars. However, if we call `sincos1!(1.0)` we see that this might not always be the best idea. Some functions should only be called with a certain data type. We can specify the data type of input and output in the following way:
```julia
function sincos1!(x::Array{Float64, 1})
    x .= sin.(cos.(x))

    return x
end
```
In the same way, we can define functions that have the same name but which perform different operations depending on the data type. For example, we can define the function `sincos(x)` which evaluates $\sin(\cos(x))$ when $x$ is a matrix or vector and returns a vector. In order to rearrange a matrix $M$ to a vector $m$ we can use `m = vec(M)`. Then, we get:
```julia
function sincos(x::Array{Float64, 1})
    println("My input is a vector.")

    return sin.(cos.(x))
end

function sincos(x::Array{Float64, 2})
    println("My input is a matrix.")

    return vec(sin.(cos.(x)))
end
```
Calling these functions gives
```julia-repl
julia> x = ones(2, 2);

julia> sincos(x)
My input is a matrix.
4-element Vector{Float64}:
 0.5143952585235492
 0.5143952585235492
 0.5143952585235492
 0.5143952585235492

julia> x = ones(4);

julia> sincos(x)
My input is a vector.
4-element Vector{Float64}:
 0.5143952585235492
 0.5143952585235492
 0.5143952585235492
 0.5143952585235492
```

Julia will always use the most specific method for the function arguments during the call.
In order to see all available methods for a specific function we can use `methods(sincos)` or any other function (e.g. `+`).

It is also possible to write new method definitions for already existing functions, which is a powerful concept for package development.
On the other hand it can also be dangerous as the following example shows

```julia-repl
julia> Base.sin(x::Float64) = "Breaking code"

julia> sincos([1.2, 2.])
My input is a vector.
2-element Vector{String}:
 "Breaking code"
 "Breaking code"
```
Here we explicetly define a new method for the base function `Base.sin` since doing `sin(...` would just define a function with
the name `sin`.
However this discouraged since both `sin` and `Float64` come from base julia and thus we are performing [type piracy](https://docs.julialang.org/en/v1/manual/style-guide/#Avoid-type-piracy).


## Element-wise operations and input specifications
As seen already, we can use the dot operation `.` to evaluate an array of inputs element-wise. Define the scalar function
```julia
function sincos(x::Real)
    return sin(cos(x))    
end
```
and run
```julia-repl
julia> x = ones(2, 3);

julia> sincos.(x)
2×3 Matrix{Float64}:
 0.514395  0.514395  0.514395
 0.514395  0.514395  0.514395
```
Fore more information see the [broadcasting section](https://docs.julialang.org/en/v1/manual/arrays/#Broadcasting) in the manual.

Moreover, we can assign values to inputs in the function definition. If the caller does not specify the input, these values will be used instead.
```julia
function myfun(x::Float64=(0.5 * pi))
    return sin(cos(x))
end
```
We can now call this function via
```julia-repl
julia> myfun()
6.123233995736766e-17

julia> myfun(0.0)
0.8414709848078965
```
Assigning default values for function arguments defines mutliple methods and is actually short hand for the following
```julia
myfun() = sin(cos(0.5 * pi))
myfun(x::Float64) = sin(cos(x))
```

## Parametric types for functions

Notice that it is very restrictive to tell our method to only accept inputs of type `Float64`. It makes perfect sense to evaluate our function at $x = 1$, where $x$ can be an integer. In fact, it is considered to be good practice if we make function inputs as general as possible.
In fact not setting a type (equivalent to `::Any`) is also possible.
Just as for *structs*, we can use parametric types to make the input more general. If we want the input to be a real number (i.e., a subtype of `Real`), we can write this as 
```julia
function myadd(x::T, y::T) where {T<:Real}
    println("Got numbers of type $(T) as input")
    return x + y
end
```
Now, `T` can be any subtype of `Real`, that is, we can write
```julia-repl
julia> myadd(1, 2)
Got numbers of type Int64 as input
3

julia> myadd(1.0, 2.0)
Got numbers of type Float64 as input
3.0
```

\exercise{
    Write a function `sincos` which can take any real number as well as the point struct we defined earlier
```julia
struct Point{T<:Real}
    x::T
    y::T
end
```
    as input. When the input is an object of type `Point`, the function returns $\sin(\cos(\Vert x \Vert))$, where $\Vert x \Vert = \sqrt{x^2 + y^2}$ is the Euclidean norm.
\solution{
```julia
struct Point{T<:Real}
    x::T
    y::T
end

sincos(x::Real) = sin(cos(x))

sincos(point::Point{<:Real}) = sincos(sqrt(point.x^2 + point.y^2))
```
Then, we get
```julia-repl
julia> sin(cos(0)) == sincos(Point(0, 0))
true

julia> sincos(1.0 + im)
ERROR: MethodError: no method matching sincos(::ComplexF64)
You may have intended to import Base.sincos
Closest candidates are:
  sincos(::Real) at REPL[2]:1
  sincos(::Point) at REPL[3]:1
Stacktrace:
 [1] top-level scope
   @ REPL[8]:1
```
}
}

## Constructors
Note from the previous exercise, that it might be convenient if every object of type `Point` computes and stores the norm. Of course this can be done by defining
```julia
struct PointFull{T<:Real}
    x::T
    y::T
    norm
end
```
and creating objects of type `PointFull` via
```julia-repl
julia> p = PointFull(1.0, 2.0, sqrt(1.0^2 + 2.0^2))
PointFull{Float64}(1.0, 2.0, 2.23606797749979)

julia> p = PointFull{Float32}(1.0, 2.0, sqrt(1.0^2 + 2.0^2))
PointFull{Float32}(1.0f0, 2.0f0, 2.23606797749979)

julia> p = PointFull{Int64}(1, 2, sqrt(1 + 2))
PointFull{Int64}(1, 2, 1.7320508075688772)
```
Note that this is quite tedious since we need to copy paste the same formula for the norm every time we construct on object. Conveniently, Julia provides us with [constructors](https://docs.julialang.org/en/v1/manual/constructors/#man-constructors), which are functions that are called whenever we create on object of our struct. The syntax is the following:
```julia
struct PointFull1{T<:Real}
    x::T
    y::T
    norm::T

    function PointFull1(x::T1, y::T2) where {T1<:Real,T2<:Real}
        T = promote_type(T1, T2)
        norm = T(sqrt(x^2 + y^2))
        new{T}(x, y, norm)
    end
end
```
Now, we can call
```julia-repl
julia> PointFull1(1.0, 2.0)
PointFull1{Float64}(1.0, 2.0, 2.23606797749979)

julia> PointFull1(1.0, 2)
PointFull1{Float64}(1.0, 2.0, 2.23606797749979)

julia> PointFull1(1, 3//4)
PointFull1{Rational{Int64}}(1//1, 3//4, 5//4)

julia> PointFull1(1, 1.0im)
ERROR: MethodError: no method matching PointFull1(::Int64, ::ComplexF64)
Closest candidates are:
  PointFull1(::T1, ::T2) where {T1<:Real, T2<:Real} at REPL[10]:6
Stacktrace:
 [1] top-level scope
   @ REPL[16]:1
```
