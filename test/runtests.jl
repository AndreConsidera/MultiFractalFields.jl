using Test, MultiFractalFields


testfiles = [
    "covariances_fields.jl",
    "normevans.jl",
    
]

# Run test suite
println("Starting tests")
ti = time()

@testset "MultiFractalFields.jl" begin
    for testfile in testfiles
      println("Testing $testfile...")
      include(testfile)
    end
end