using Test, MultiFractalFields


testfiles = [
    "covariances_fields.jl",
    "normevans.jl",
    "covariances/linear.jl",
    "covariances/exponential.jl",
    "covariances/log.jl",
    
]

# Run test suite
println("Starting tests")
@testset "MultiFractalFields.jl" begin
    for testfile in testfiles
      println("Testing $testfile...")
      include(testfile)
    end
end