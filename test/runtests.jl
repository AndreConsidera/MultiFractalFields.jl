using Test, MultiFractalFields

testfiles = [
    "field.jl",
    "normevans.jl",
    "realization.jl",
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

ti = time() - ti
println("\nTest took total time of:")
println(round(ti/60, digits = 3), " minutes")
