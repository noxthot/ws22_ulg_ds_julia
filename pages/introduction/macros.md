@def title = "Introduction - Metaprogramming"
@def hascode = true

@def tags = ["introduction", "macros", "metaprogramming"]

# Metaprogramming

[Metaprogramming](https://docs.julialang.org/en/v1/manual/metaprogramming) is a very powerful concept of Julia.
Since Julia code is itself represented in the language via its own datastructure (an `Expr`) a Julia program can
freely manipulate and generate its own code. However, in this section we will only give a brief overview of the
concepts of metaprogramming because it is a more advanced feature of the language. First we give a short overview of
how Julia code is actually run. To get from text to native code roughly the following steps are performed:
1. Parsing (`Meta.parse`)
2. Lowering and type inference (`@code_warntype`)
3. Compile to LLVM intermediate representation (`@code_llvm`)
4. Compile to native code using LLVM (`@code_native`)

where we put the function/macro in the parentheses that yields the output of the corresponding step i.e. one can use
them to look at the outputs of them interactively. In step 1 the code is read and transformed into `Expr`s. Then
types are computed/inferred which means that the compiler tries to find out the concrete type of each expression i.e.
each variable and each return type. If type inference fails, it gets highlighted in the output of `@code_warntype`. This can be useful because it can cause big performance problems.
The final two steps are not really important for us since their output is already quite low level and difficult to
read and understand. But one can use `@code_llvm` to debug performance problems or for optimization.
Metaprogramming is usually performed in between steps 1 and 2 and one common use case are macros.

At its basis, a macro is similar to a function, as it maps a tuple of arguments to a returned expression. 
Therefore, in order to distinguish macros in the code, Julia reserves the `@` symbol as the first character for macro definitions. 
Apart from that convention, there are two major differences between macros and functions.
A macro:
1. is compiled directly and not at the first call,
2. is executed when the code is parsed.

The second feature is the important one, as we can manipulate the code at runtime.
The nice thing about macros is, we can insert quite powerful code by still keeping the readability high. 
We have already seen multiple macros i.e. `@time` which basically just inserts `Base.time_ns()` before the expression
passed to the macro and after it and then returns the difference (the actual definitions is more complex). Once the
code is run we thus get the time it took to run the code contained in the expression passed to the macro. The `@time`
macros is more convenient than a function since it allows the timing of arbitrary Julia code which would not be
possible with a function.
Defining a useful macro can be quite difficult/different compared to ordinary Julia code, because one has to perform
all operations on `Expr`. Thus we will not discuss it here. However, one should look at the documentation of all the
macros used this far and also the following ones: `@view`, `@views`, `@.`, `@assert`, `@info`, `@warn`,
`@error` and `@__DIR__`.

Finally we will show an example of another use case for metaprogramming namely the definition of multiple functions
using a loop.
In the following example from the manual we have defined a custom number type. Now we also want to define methods
of common built-in functions for this type. One could easily do this by hand but using metaprogramming makes it
shorter and easier to read and extend.
```julia
struct MyNumber
    x::Float64
end

for op in (:sin, :cos, :tan, :log, :exp)
    @eval Base.$op(a::MyNumber) = MyNumber($op(a.x))
end
```
Here the main ingredient is the `@eval` macro which creates an expression and then evaluates it i.e. it is equivalent
to `eval(:(Base.$op(a::MyNumber) = MyNumber($op(a.x))))`. The above method can also be used for more complex function
definitions not just one liners.
