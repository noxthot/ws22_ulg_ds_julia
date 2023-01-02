@def title = "Useful packages"
@def hascode = false

@def tags = ["introduction", "packages"]

# Useful packages

- [Flux.jl](https://fluxml.ai/Flux.jl/stable/)
  Machine learning API which includes built-in layers, activation and loss functions,
  as well as optimization routines.

- [MLUtils.jl](https://juliaml.github.io/MLUtils.jl/dev/) An extensible interface about handling data sets with data
  loaders, resampling, train/test splits, data partitioning, and more data handling utilities.

- [Plots.jl](https://docs.juliaplots.org/latest/) High-level visualization interface and toolset combining multiple plotting backends into a single API. For more specific needs also check out [Makie.jl](https://docs.makie.org/stable/).

- [Distributions.jl](https://juliastats.org/Distributions.jl/stable/) Everything related to probabilistic
  distributions. Part of the [JuliaStats](https://juliastats.org/) organization which is dedicated to providing
  high-quality packages for statistics.

- [Optim.jl](https://julianlsolvers.github.io/Optim.jl/stable/) Uni- and multivariate optimization library. The [Optimization.jl](https://docs.sciml.ai/Optimization/stable/) package provides a unified Julia API by bringing together multiple optimization packages.

- [LoopVectorization.jl](https://juliasimd.github.io/LoopVectorization.jl/stable/) Provides the `@turbo` macro which
  tries to vectorize a `for` loop or broadcast statement. Leads to improved runtime performance if used correctly.

- [Documenter.jl](https://documenter.juliadocs.org/stable/) Combine Markdown files with inline docstrings to render a
  single inter-linked document. See also [Reporting](../../reporting).

- [Pluto.jl](https://plutojl.org/) Simple browser-based Julia programming environment with built-in package manager. Add interactivity with reactive elements like sliders, buttons, etc. using [PlutoUI.jl](https://docs.juliahub.com/PlutoUI/abXFp/0.7.49/). See also [Reporting](../../reporting).

- [DataFrames.jl](https://dataframes.juliadata.org/stable/) Handle any kind of tabular data in Julia. Its design and functionality are similar to those of pandas in Python. See also [Data Management](../../data_management).

- [ProgressMeter.jl](https://github.com/timholy/ProgressMeter.jl) Track the status of long-running operations in
  Julia with a progress bar.

- [JLD2.jl](https://juliaio.github.io/JLD2.jl/dev/) An efficient data format for serializing Julia objects similar to
  HDF5.
