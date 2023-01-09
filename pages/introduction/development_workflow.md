@def title = "Development workflow"
@def hascode = false

@def tags = ["introduction", "development", "workflow"]

# Development workflow

## Project setup

Julia has an built-in function `Pkg.generate` which generates the minimal file structure for a new project. For example,
to initialize a project called `ULG` all you need to do is run the following commands.

```julia-repl
julia> using Pkg

julia> Pkg.generate("ULG.jl")
  Generating  project ULG:
    ULG.jl/Project.toml
    ULG.jl/src/ULG.jl
Dict{SubString{String}, Base.UUID} with 1 entry:
  "ULG" => UUID("7f50121b-566d-49a5-8387-754b659c937e")
```

This writes two important files to disk.
- `Project.toml` contains metainformation about the project and (optionally) a list of required packages including their
  version restrictions.
- `src/ULG.jl` the main code file where the `ULG` module is defined.

To load and use the `ULG` package first activate the package environment then load the code with `using ULG`.

## Modules

[Modules](https://docs.julialang.org/en/v1/manual/modules/) are a way of organizing code in Julia. For example, each
package is a module of its own. Above we generated the `ULG` module. After loading it all of the function and variables
can not be used directly since they are in the module's own namespace. Thus, we have to prepend `ULG.` e.g.
`ULG.greet()`. It is also inconvenient to put all of your code into a single file. Julia provides the `include`
function which behaves as if the contents of the source file were written in the `ULG.jl` file.

As we have already seen in the exercise of the [Functions#Syntax](/pages/introduction/functions#syntax) section with
`mean` we do not always have to put the module name in front of the function. Julia achieves this with the `export`
keyword. In order to make the `ULG.greet` function available inside of the global scope (after `using ULG`) we just add the
line `export greet` to `src/ULG.jl`.

## Testing

When we are done programming our package it is always good practice to write [unit
tests](https://pkgdocs.julialang.org/dev/creating-packages/#Adding-tests-to-the-package). These code snippets test
whether our code behaves as intended. Start by creating the `test/` folder and put a file called `runtests.jl` inside
it. This file tells Julia how to run all tests. In order to test `ULG.greet` we could for example add these lines.

```julia
using Test
using ULG

@testset begin
    @test isnothing(ULG.greet())
    @test 1 + 1 == 3
end
```

Then we can run these tests with
```julia-repl
(ULG) pkg> add Test

(ULG) pkg> test

Test Summary: | Pass  Fail  Total  Time
test set      |    1     1      2  0.5s
ERROR: LoadError: Some tests did not pass: 1 passed, 1 failed, 0 errored, 0 broken.
in expression starting at /tmp/ULG/test/runtests.jl:4
ERROR: Package ULG errored during testing
```

## Revise

After we have changed existing code Julia needs to recompile it. Depending on the package size restarting Julia for this
can take a while. However, we do not necessarily have to exit Julia since only the files containing the changes need to
be reloaded. [`Revise`](https://timholy.github.io/Revise.jl/stable/) automates this task.

```julia-repl
julia> using Revise

julia> using ULG

# here we edit some code

julia> revise()

# new code is loaded without restarting
```
