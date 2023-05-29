@testset "Exponential covariance" begin
    for T in [Float16, Float32, Float64, Int16, Int32, Int64]
       @test Exponential{T}<:Covariance{T}  
    end

    # checking variance, correlation length, scaling exponent
    for (ξ, λ , σ², r) in zip(rand(1000), rand(1000), rand(1000), rand(1000))
        expcov = Exponential(ξ, λ, σ²)
        @test typeof(expcov)<:Covariance
        @test expcov(0) == expcov.σ²
        @test expcov(expcov.λ) ≈ expcov.σ²/ℯ
        # testing scaling exponent
        r = min(r, expcov.λ)
        @test log(expcov(r)) - log(expcov.σ²) ≈ - (r/expcov.λ)^(expcov.ξ)
    end

    
    @testset "Default constructor" begin
        # checking variance, correlation length, scaling exponent
        for (ξ, r) in zip(rand(1000), rand(1000))
            expcov = Exponential(ξ)
            @test typeof(expcov)<:Covariance
            @test expcov(0) == 1
            @test expcov(1) ≈ 1/ℯ
            # testing scaling exponent
            r = min(r, 1)
            @test log(expcov(r)) ≈ - (r)^(expcov.ξ)
        end
    end
end