@def title = "Introduction"
@def hascode = true

@def tags = ["introduction"]

# Introduction to Julia 

## Running Julia code

There are several ways to write and run Julia code:

### The Julia [REPL](https://docs.julialang.org/en/v1/stdlib/REPL/) (read-evaluate-print-loop)

Fire it up by typing `julia` (or the full path to the executable) in the command-line interface (CLI). The REPL itself comes with four distinct modes:
- **Julia mode**: This is the default mode when we start Julia. The prompt starts with `julia>`. Here we may type Julia expressions which get evaluated when pressing enter. The resulting output will be presented immediately after evaluation.
\example{```julia-repl
julia> 1 + 1
2

julia> 
```
}
- **Package mode**: We can switch to this mode by typing `]`. The prompt will change to `(@v1.8) pkg>` (version number depends on the installation). Here we can directly interact with the [package manager](./package_manager/) to add or update packages. To get a complete list of possibilities type `?`
\example{```julia-repl
(@v1.8) pkg> ?
  Welcome to the Pkg REPL-mode. To return to the julia> prompt, either press backspace when the input line is empty or press Ctrl+C.

  Full documentation available at https://pkgdocs.julialang.org/

  Synopsis

  pkg> cmd [opts] [args]

  Multiple commands can be given on the same line by interleaving a ; between the commands. Some commands have an alias, indicated below.

  Commands

  activate: set the primary environment the package manager manipulates

  add: add packages to project

  build: run the build script for packages

  compat: edit compat entries in the current Project and re-resolve

  develop, dev: clone the full package repo locally for development

  free: undoes a pin, develop, or stops tracking a repo

  gc: garbage collect packages not used for a significant time

  generate: generate files for a new project

  help, ?: show this message

  instantiate: downloads all the dependencies for the project

  pin: pins the version of packages

  precompile: precompile all the project dependencies

  redo: redo the latest change to the active project

  remove, rm: remove packages from project or manifest

  resolve: resolves to update the manifest from changes in dependencies of developed packages

  status, st: summarize contents of and changes to environment

  test: run tests for packages

  undo: undo the latest change to the active project

  update, up: update packages in manifest

  registry add: add package registries

  registry remove, rm: remove package registries

  registry status, st: information about installed registries

  registry update, up: update package registries

(@v1.8) pkg> 
```
}
- **Help mode**: Type `?` and the prompt will change to `help?>`. Julia prints the help and documentation for everything we ask for (related to Julia).
\example{
```julia-repl
help?> +
search: +

  +(x, y...)

  Addition operator. x+y+z+... calls this function with all arguments, i.e. +(x, y, z, ...).

  Examples
  ≡≡≡≡≡≡≡≡≡≡

  julia> 1 + 20 + 4
  25
  
  julia> +(1, 20, 4)
  25

  ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

  dt::Date + t::Time -> DateTime

  The addition of a Date with a Time produces a DateTime. The hour, minute, second, and millisecond parts of the Time are used along with the year, month, and day of the Date to create the new DateTime. Non-zero microseconds
  or nanoseconds in the Time type will result in an InexactError being thrown.

julia>
```
}
- **Shell mode**: We can switch to this mode by typing `;` and the prompt will change to `shell>`. Now we are in the usual shell and are able to type any command we want to evaluate.
\example{
```
shell> pwd
/home/user/ws22_julia_ulg

shell>
```
}

@@important
You may **exit** any of these modes by (repeatedly) pressing **backspace**.
@@

Note that all these modes use Julia functions under the hood. For example `?+` is equivalent to `Base.Docs.doc(+)`. All package functions can be called inside Julia using `import Pkg` and, e.g., `Pkg.update()`.

### VS Code 
See [Julia and VS Code](../../#julia_and_vs_code).

### Other interactive development environments 
A lot of other IDEs or text editors like Jupyter, Sublime Text, Nano, vim and many more can also be used in connection with Julia. Some integrate the evaluation inside the editor. For others we will have to do this in the CLI. Note that we can always run Julia code from CLI by typing `julia myProgram.jl`.

If we are just exploring of what Julia is capable of or need some help regarding specific Julia functionality the REPL is very useful. However, once we want to run a program or repeat a process we switch to running code from a file. In the REPL we can use the arrow keys *up* and *down* to navigate through previous calls (if our CLI allows it).

## Additional sources

If you are already familiar with another programming language it might be worth visiting [Noteworthy Differences from other Languages](https://docs.julialang.org/en/v1/manual/noteworthy-differences/) from the Julia documentation. 

