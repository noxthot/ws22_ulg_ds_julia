# This file was generated, do not modify it. # hide
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