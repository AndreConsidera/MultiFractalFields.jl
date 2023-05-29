@testset "Linear covariance" begin
    for T in [Float16, Float32, Float64, Int16, Int32, Int64]
       @test Linear{T}<:Covariance{T}  
    end

    # checking variance, correlation length, scaling exponent
    for (ξ, λ , σ², r) in zip(rand(1000),rand(1000),rand(1000), rand(1000))
        lincov = Linear(ξ, λ, σ²)
        @test typeof(lincov)<:Covariance
        @test lincov(0) == lincov.σ²
        @test lincov(lincov.λ) == 0
        # testing scaling exponent
        r = min(r, lincov.λ)
        @test (lincov.σ² - lincov(r))/lincov.σ² ≈ (r/lincov.λ)^(lincov.ξ)
    end

    @testset "Default constructor" begin
        # checking variance, correlation length, scaling exponent
        for (ξ, r) in zip(rand(1000), rand(1000))
            lincov = Linear(ξ)
            @test typeof(lincov)<:Covariance
            @test lincov(0) == 1
            @test lincov(1) == 0
            # testing scaling exponent
            r = min(r, 1)
            @test (1 - lincov(r)) ≈ (r)^(lincov.ξ)
        end
    end

end
