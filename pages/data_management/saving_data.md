@def title = "Saving Dataframes and Tables.jl"
@def hascode = true

@def tags = ["Data Science", "Dataframes", "Tables.jl"]

# Saving dataframes

Now that we prepared our data source and noticed how much work it was to restore the original data types, it make sense to save the current state of our dataframe. Our data source was provided in the CSV format which has the major disadvantage that Julia needs to elaborately guess the data type of each column, the used decimal symbol, and so on. But it is also possible to store this so-called meta data along with the dataframe. [`Arrow.jl`](https://arrow.juliadata.org/stable/) provides sufficient metadata to know how each item has to be interpreted (at least for simple types). Additionally, this format is compatible across different computer architectures and can be read with various programming languages (like e.g. Julia, Python and R).

To write a dataframe into an arrow-file simply call:
```julia
using Arrow

Arrow.write("survey.arrow", df_survey)
```

We can also pass additional options such as `compress = :zstd` for compressing the data.
Loading the file again is slightly more complicated since `Arrow.Table` is immutable by default and not fully loaded
into memory. Thus we need to `copy` each column in order to convert the Arrow data into normal `Vector`s.
```julia
using Arrow, DataFrames

df_survey = DataFrame(Arrow.Table("survey.arrow"); copycols=true)
```

# Tables.jl

Columnar data also called tables is quite a general concept seen in databases, CSV files, Excel files, `Dataframes` and
in many more instances. It would be possible to always use `DataFrames` in order for Julia to interact with these.
However, `DataFrames` are quite special since they make certain assumptions on the table e.g. that each element can be
accessed and changed independently. But we have already seen above that for `Arrow.Table` this is not the case.

So packages which operate on tabular data e.g. [SQLite.jl](https://juliadatabases.org/SQLite.jl/stable/) and
[CSV.jl](https://csv.juliadata.org/stable/)  do not use `Dataframes` but the small interface package
[Tables.jl](https://tables.juliadata.org/stable/) which defines a common set of functions that should work on all
tabular data types. Thus [each package](https://github.com/JuliaData/Tables.jl/blob/master/INTEGRATIONS.md) implementing
the table interface can work with a `DataFrame` or other tabular types. For example

```julia-repl
julia> using Arrow, Tables, DataFrames

julia> table = (x = [1, 2, 3], y = ["a", missing, "b"], z = rand(3));

julia> Tables.istable(table)
true

julia> Tables.schema(table)
Tables.Schema:
 :x  Int64
 :y  Union{Missing, String}
 :z  Float64

julia> Arrow.write("test.arrow", table)
"test.arrow"

julia> df = DataFrame(Arrow.Table("test.arrow"); copycols=true)
3×3 DataFrame
 Row │ x      y        z         
     │ Int64  String?  Float64   
─────┼───────────────────────────
   1 │     1  a        0.457727
   2 │     2  missing  0.0677743
   3 │     3  b        0.529353

julia> Tables.istable(df)
true

julia> Tables.materializer(df)
DataFrame

julia> Tables.materializer(table)
columntable (generic function with 5 methods)

julia> Tables.materializer(table)(df)
(x = [1, 2, 3], y = Union{Missing, String}["a", missing, "b"], z = [0.45772704497893035, 0.06777425699530504, 0.5293528119836353])
```

Let us go into more details on each concept that we see her:
- any `NamedTuple` of vectors is a table
- `Arrow.write` accept and can save any table
- `Tables.materializer` returns the initialization/construction functions of the input table
- the materializer for dataframes is simply `DataFrame`

The last point is important since it means that any `Tables.jl` compatible type can be converted into a `DataFrame`
by using `DataFrame(...; copycols=true)` and then work with it as expected.
