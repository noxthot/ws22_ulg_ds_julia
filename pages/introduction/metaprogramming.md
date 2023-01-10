@def title = "Introduction - Metaprogramming"
@def hascode = true

@def tags = ["introduction", "macros", "metaprogramming"]

# Metaprogramming

[Metaprogramming](https://docs.julialang.org/en/v1/manual/metaprogramming) is a very powerful concept.
Since Julia code itself is represented in the language via its own datastructure (an `Expr`ession) a Julia program can
freely manipulate and generate its own code. However, in this section we only give a short overview of metaprogramming concepts because it is an advanced feature of the language. When we run Julia code roughly the following steps are performed to get from text to native code:

1. Parsing (`Meta.parse`)
1. Lowering and type inference (`@code_warntype`)
1. Compile to LLVM intermediate representation (`@code_llvm`)
1. Compile to native code using LLVM (`@code_native`)

The function/macros in parentheses allow us to further investigate each step by letting us take a look at the output interactively. In step 1 the code is read and transformed into `Expr`essions. Then
the compiler tries to find the concrete type of each expression i.e.
each variable and each return type. If type inference fails, it is highlighted in the `@code_warntype` output. This can be useful since it sometimes leads to performance problems.
The final two steps are not really important for us since their output is already quite low level and difficult to
read and understand. But one can use `@code_llvm` to debug performance problems or for optimization.
Metaprogramming is usually performed between steps 1 and 2. A common use case are macros.

In principle a macro is similar to a function as it maps a tuple of arguments to an expression that is then returned.
Therefore, Julia reserves the `@` symbol as the first character for macro definitions in order to distinguish them from functions in the code.
Apart from that what differentiates macros from functions most is that macros

1. are compiled directly and not at first call,
1. are executed when the code is parsed.

The second feature is the important one as it lets us manipulate code at runtime.
Another convenient thing about macros is their ability to insert quite powerful code while also keeping the readability high.
We have already seen multiple macros, e.g., `@time` which basically just inserts `Base.time_ns()` before and after the expression
passed to the macro and returns the difference. Keep in mind that the actual definition is more complex.

```julia-repl
julia> @time sleep(1)
  1.002452 seconds (5 allocations: 144 bytes)
```

In contrast to functions it is possible to time arbitrary Julia code with the `@time` macro. Defining a useful macro can be difficult and also quite different from ordinary Julia code because all operations have to be performed on `Expr`. Thus, we will not discuss it here. However, have a look at the documentation of all the
macros we have been using so far as well as these ones: `@view`, `@views`, `@.`, `@assert`, `@info`, `@warn`,
`@error` and `@__DIR__`.

Another useful example for metaprogramming is the definition of multiple functions using a `for` loop.
In the following example from the [Julia manual](https://docs.julialang.org/en/v1/manual/metaprogramming/#Code-Generation) we have defined a custom number type. We would also like to define methods of common built-in functions for this type. We could do it manually but metaprogramming makes it shorter, easier to read, and easier to extend.

```julia
struct MyNumber
    x::Float64
end

for op in (:sin, :cos, :tan, :log, :exp)
    @eval Base.$op(a::MyNumber) = MyNumber($op(a.x))
end
```

The main ingredient is the `@eval` macro which creates an expression and then evaluates it. This is equivalent to `eval(:(Base.$op(a::MyNumber) = MyNumber($op(a.x))))`. The above method can also be used for more complex function definitions and not just one-liners.
