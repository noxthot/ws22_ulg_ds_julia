@def title = "Exercise"
@def hascode = true

@def tags = ["Neural Networks", "Exercise"]

# Our Exercise

\toc


## Preparations
Since you are familiar with git and gitlab, you might want to fork the repository of our exercise first. To do so, head to [gitlab](https://git.uibk.ac.at/c7021138/ulg_ws22_julia_workshop_exercises_pub).

Afterwards clone your forked repository with
```bash
git clone <YOUR_FORK>
```

Head to this project and open the Julia REPL (be sure to use the default version of this course).
The project comes with a `Manifest.toml` and `Project.toml`, so be sure to activate and instantiate the environment:
```julia-repl
(@v1.8) pkg> activate .
  Activating project at `~/uibk/teaching/ulg-ws-22-julia-workshop-exercises-pub`

(ulg-ws-22-julia-workshop-exercises-pub) pkg> instantiate
```

In this exercise we will work with [JupyterLab](https://jupyter.org/). The Package [`IJulia`](https://github.com/JuliaLang/IJulia.jl) is a Julia-language backend combined with the Jupyter interactive environment and enables us to use JupyterLab with Julia. You already instantiated this package in your environment, so from the REPL simply call:
```julia-repl
julia> using IJulia
```

And to open JupyterLab with the current directory being the working directory, call:
```julia-repl
julia> jupyterlab(dir=pwd())
```

In case you do not have Jupyter ready on your system, IJulia will offer you to install Jupyter via Conda. You might want to take this offer and let IJulia do the work for you. Once ready, JupyterLab will be started and your default Browser open with the JupyterLab start screen.

Sometimes you will not find your desired Julia Kernel. Usually closing JupyterLab, and rebuilding your IJulia from the desired Julia version should fix this problem:
```julia-repl
pkg> activate .
  Activating project at `~/uibk/teaching/ulg_ws22_julia_workshop_exercises_pub`

(ulg_ws22_julia_workshop_exercises_pub) pkg> build IJulia
```