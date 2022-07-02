@def title = "Dataframes"
@def hascode = true

@def tags = ["Data Science", "Dataframes"]

# Dataframes

Data Science mostly requires to work with tabular data. With [`DataFrames.jl`](https://dataframes.juliadata.org/stable/) Julia provides a set of tools for working with tabular data. When you are already familiar with `pandas` (Python) or `dplyr` (R) you will be quickly able to get started with Data Wrangling using `DataFrames.jl` since design and functionality are quite similar.

First of all you of course need to add and load the package:
```julia-repl
pkg> add DataFrames
julia> use DataFrames
```

Let us start with an empty `DataFrame`:
```julia-repl
julia> DataFrame()
0×0 DataFrame
```

It is also easy to initialize a `DataFrame` with a couple of columns:
```julia-repl
julia> DataFrame(country=["Austria", "Germany", "Switzerland"], population=[8_917_000, 83_240_000, 8_637_000], continent="Europe")
3×3 DataFrame
 Row │ country      population  continent 
     │ String       Int64       String    
─────┼────────────────────────────────────
   1 │ Austria         8917000  Europe
   2 │ Germany        83240000  Europe
   3 │ Switzerland     8637000  Europe
```

Note that the continent was given as scalar "Europe" and broadcasted to fill every row of the created `DataFrame`.

In case you want to initialize a `DataFrame` with names that are not valid Julia identifiers (e.g. containing spaces) you can also use the following form:
```julia-repl
julia> DataFrame("country" => ["Austria", "Germany", "Switzerland"], "population 2020" => [8_917_000, 83_240_000, 8_637_000], "continent" => "Europe")
3×3 DataFrame
 Row │ country      population 2020  continent 
     │ String       Int64            String    
─────┼─────────────────────────────────────────
   1 │ Austria              8917000  Europe
   2 │ Germany             83240000  Europe
   3 │ Switzerland          8637000  Europe
```

And in case you already got your data in a dictionary where the keys are `Strings` or `Symbols`, simply initialize your `DataFrame` using that dictionary:
```julia-repl
julia> mydict = Dict("country" => ["Austria", "Germany", "Switzerland"], "population 2020" => [8_917_000, 83_240_000, 8_637_000], "continent" => "Europe")
Dict{String, Any} with 3 entries:
  "population 2020" => [8917000, 83240000, 8637000]
  "continent"       => "Europe"
  "country"         => ["Austria", "Germany", "Switzerland"]

julia> DataFrame(mydict)
3×3 DataFrame
 Row │ continent  country      population 2020 
     │ String     String       Int64           
─────┼─────────────────────────────────────────
   1 │ Europe     Austria              8917000
   2 │ Europe     Germany             83240000
   3 │ Europe     Switzerland          8637000
```

Also note that the data types of the columns are printed.

## Working with real data

To get things more exciting, let us take a look at real data. [Stack Overflow](www.stackoverflow.com) provides [annual developer surveys](https://insights.stackoverflow.com/survey/). We will have a look at the latest available data set from [2021](https://info.stackoverflowsolutions.com/rs/719-EMH-566/images/stack-overflow-developer-survey-2021.zip). Please download this file and extract it into your workspace. Note that beside that actual data there is also a file which describes the contents of the dataset.

The file's name is `survey_results_public.csv` and the extension indicates that the file format is a [comma-seperated values](https://en.wikipedia.org/wiki/Comma-separated_values) file. Thus we need a package that is able to handle CSV-files. Luckily there is [CSV.jl](https://csv.juliadata.org/stable/) which makes it easy to load a file into a `DataFrame`. All we need to do is add and load `CSV` and read the data by using `DataFrame` as sink (second argument). Sink? How do we even know that such a thing exists? It is always good to consult the manual first:
```julia-repl
pkg> add CSV
[..]
julia> using CSV

help?> CSV
search: CSV

  CSV provides fast, flexible reader & writer for delimited text files in various formats.

  Reading:

    •  CSV.File reads delimited data and returns a CSV.File object, which allows dot-access to columns and iterating rows.

    •  CSV.read is similar to CSV.File but used when the input will be passed directly to a sink function such as a DataFrame.

    •  CSV.Rows reads delimited data and returns a CSV.Rows object, which allows "streaming" the data by iterating and thereby has a lower
       memory footprint than CSV.File.

    •  CSV.Chunks allows processing extremely large files in "batches" or "chunks".

  Writing:

    •  CSV.write writes a Tables.jl interface input (https://github.com/JuliaData/Tables.jl) such as a DataFrame to a csv file or an in-memory
       IOBuffer.

    •  CSV.RowWriter creates an iterator that produces csv-formatted strings for each row in the input table.

  Here is an example of reading a csv file and passing the input to a DataFrame:

  using CSV, DataFrames
  ExampleInputDF = CSV.read("ExampleInputFile.csv", DataFrame)

  Here is an example of writing out a DataFrame to a csv file:

  using CSV, DataFrames
  ExampleOutputDF = DataFrame(rand(10,10), :auto)
  CSV.write("ExampleOutputFile.csv", ExampleOutputDF)

help?> CSV.read
  CSV.read(source, sink::T; kwargs...) => T

  Read and parses a delimited file or files, materializing directly using the sink function. Allows avoiding excessive copies of columns for certain
  sinks like DataFrame.
[..]
```

Equipped with this knowledge we are now ready to load the file:
```julia-repl
julia> df = CSV.read("survey_results_public.csv", DataFrame)
83439×48 DataFrame
   Row │ ResponseId  MainBranch                         Employment                         Country                            US_State       UK_Coun ⋯
       │ Int64       String                             String                             String                             String         String3 ⋯
───────┼──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
     1 │          1  I am a developer by profession     Independent contractor, freelanc…  Slovakia                           NA             NA      ⋯
     2 │          2  I am a student who is learning t…  Student, full-time                 Netherlands                        NA             NA
     3 │          3  I am not primarily a developer, …  Student, full-time                 Russian Federation                 NA             NA
     4 │          4  I am a developer by profession     Employed full-time                 Austria                            NA             NA
     5 │          5  I am a developer by profession     Independent contractor, freelanc…  United Kingdom of Great Britain …  NA             England ⋯
     6 │          6  I am a student who is learning t…  Student, part-time                 United States of America           Georgia        NA
   ⋮   │     ⋮                       ⋮                                  ⋮                                  ⋮                        ⋮            ⋮   ⋱
 83435 │      83435  I am a developer by profession     Employed full-time                 United States of America           Texas          NA
 83436 │      83436  I am a developer by profession     Independent contractor, freelanc…  Benin                              NA             NA
 83437 │      83437  I am a developer by profession     Employed full-time                 United States of America           New Jersey     NA      ⋯
 83438 │      83438  I am a developer by profession     Employed full-time                 Canada                             NA             NA
 83439 │      83439  I am a developer by profession     Employed full-time                 Brazil                             NA             NA
                                                                                                                     43 columns and 83428 rows omitted
```

The first thing you will notice when working with real data is that there is more data than you can fit on one screen. So let us look at a couple of methods which help to get an overview. `names(df)` gives a list of columns:
```julia-repl
julia> names(df)
48-element Vector{String}:
 :ResponseId
 :MainBranch
 :Employment
 :Country
 :US_State
 :UK_Country
 :EdLevel
 :Age1stCode
 ⋮
 :Sexuality
 :Ethnicity
 :Accessibility
 :MentalHealth
 :SurveyLength
 :SurveyEase
 :ConvertedCompYearly
```

Unfortunately the vector has too many elements and also gets summarized. The full output can be shown with `show`:
```julia-repl
julia> show(names(df))
["ResponseId", "MainBranch", "Employment", "Country", "US_State", "UK_Country", "EdLevel", "Age1stCode", "LearnCode", "YearsCode", "YearsCodePro", "DevType", "OrgSize", "Currency", "CompTotal", "CompFreq", "LanguageHaveWorkedWith", "LanguageWantToWorkWith", "DatabaseHaveWorkedWith", "DatabaseWantToWorkWith", "PlatformHaveWorkedWith", "PlatformWantToWorkWith", "WebframeHaveWorkedWith", "WebframeWantToWorkWith", "MiscTechHaveWorkedWith", "MiscTechWantToWorkWith", "ToolsTechHaveWorkedWith", "ToolsTechWantToWorkWith", "NEWCollabToolsHaveWorkedWith", "NEWCollabToolsWantToWorkWith", "OpSys", "NEWStuck", "NEWSOSites", "SOVisitFreq", "SOAccount", "SOPartFreq", "SOComm", "NEWOtherComms", "Age", "Gender", "Trans", "Sexuality", "Ethnicity", "Accessibility", "MentalHealth", "SurveyLength", "SurveyEase", "ConvertedCompYearly"]
```

Let us assume that we are conducting a little study on incomes of different developer roles and therefore we are only interested in the columns: `["Age", "Country", "ConvertedCompYearly", "DevType", "Employment", "Ethnicity", "Gender", "OrgSize", "YearsCode"]`. Unfortunately `ConvertedCompYearly` is not further described within the dataset schema but it is probably fair to assume that this reflects the annual income in dollars. Selecting various columns works with `df[!, cols]` notation:
```julia-repl
julia> selcols = ["Age", "Country", "ConvertedCompYearly", "DevType", "Employment", "Ethnicity", "Gender", "OrgSize", "YearsCode"]
[...]

julia> df[!, selcols]
83439×9 DataFrame
   Row │ Age              Country                            ConvertedCompYearly  DevType                            Employment                       ⋯
       │ String31         String                             String15             String                             String                           ⋯
───────┼───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
     1 │ 25-34 years old  Slovakia                           62268                Developer, mobile                  Independent contractor, freelanc ⋯
     2 │ 18-24 years old  Netherlands                        NA                   NA                                 Student, full-time
   ⋮   │        ⋮                         ⋮                           ⋮                           ⋮                                  ⋮                ⋱
 83438 │ 25-34 years old  Canada                             816816               Developer, back-end                Employed full-time
 83439 │ 18-24 years old  Brazil                             21168                Developer, front-end;Developer, …  Employed full-time
                                                                                                                       5 columns and 83435 rows omitted
```

Do you notice that something odd happened? `ConvertedCompYearly` apparently is stored as a `String15` (meaning a `String` with fixed length of 15 letters) column. Taking a closer look at the data and/or CSV file, this is due to `NA` being used as text in the CSV file. We obviously want this column to be of type `Integer` (to be more precise of type `Union{Integer, Missing}`) and the `NA`s should be `missing`. If we would have known about this earlier, we could have corrected this right at the start when reading the dataframe. This also counts for various other problems that often occur with this file format. Non-standard seperation letter, different symbols for writing decimal numbers to just name two. Reading the manual of `CSV.read` tells how we should read the data correctly and we can even immediately tell that we only want to read specific columns:
```julia-repl
julia> df = CSV.read("survey_results_public.csv", DataFrame; missingstring="NA", select=selcols)
83439×9 DataFrame
   Row │ Employment                         Country                            YearsCode  DevType                            OrgSize                            Age  ⋯
       │ String?                            String                             String31?  String?                            String?                            Stri ⋯
───────┼──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
     1 │ Independent contractor, freelanc…  Slovakia                           missing    Developer, mobile                  20 to 99 employees                 25-3 ⋯
     2 │ Student, full-time                 Netherlands                        7          missing                            missing                            18-2
   ⋮   │                 ⋮                                  ⋮                      ⋮                      ⋮                                  ⋮                       ⋱
 83438 │ Employed full-time                 Canada                             5          Developer, back-end                20 to 99 employees                 25-3
 83439 │ Employed full-time                 Brazil                             14         Developer, front-end;Developer, …  I don’t know                       18-2
                                                                                                                                      4 columns and 83435 rows omitted
```

Since `ConvertedCompYearly` is not displayed in this last output, we will take a look at the column type by applying `eltype()`:
```julia-repl
julia> eltype(df.ConvertedCompYearly)
Union{Missing, Int64}
 ```

 Let us also have a look at the types of the rest of the columns. This unfortunately is a bit technical:
```julia-repl
 julia> collect(zip(names(df), eltype.(eachcol(df))))
9-element Vector{Tuple{String, Type}}:
 ("Employment", Union{Missing, String})
 ("Country", String)
 ("YearsCode", Union{Missing, String31})
 ("DevType", Union{Missing, String})
 ("OrgSize", Union{Missing, String})
 ("Age", Union{Missing, String31})
 ("Gender", Union{Missing, String})
 ("Ethnicity", Union{Missing, String})
 ("ConvertedCompYearly", Union{Missing, Int64})
 ```

 The function `eachcol()` creates a vector-like object that allows iterating over each dataframe column, `eltype()` returns the data type of an object and by using `eltype.()` we apply `eltype()` to each column. This would return a vector of column types but unfortunately we can not see the according column names. To get the names too we use `names()`. `zip` ties together the $n$th column name with the $n$th column type, but this function also returns an iterator. Finally `collect()` returns an array of all items within that iterator which can be printed easily.

\exercise{
 When having a look at the output it might seem like `Age`, `YearsCode` and `OrgSize` probably should also be of a numeric type. Apply `unique()` to these columns to check whether those columns should be converted.}