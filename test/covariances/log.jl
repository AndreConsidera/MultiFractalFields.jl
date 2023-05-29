@testset "Log covariance" begin
    for T in [Float16, Float32, Float64, Int16, Int32, Int64]
       @test Log{T}<:SingularCovariance{T}  
    end

    # checking variance, correlation length, scaling exponent
    for (λ, r) in zip(rand(1000), rand(1000))
        logcov = Log(λ)
        @test typeof(logcov)<:SingularCovariance
        @test logcov(0) == Inf
        @test logcov(logcov.λ) == 0
        r = min(r, logcov.λ)
        @test logcov(r) ==log(logcov.λ/abs(r))
    end
    
    
    @testset "Default constructor" begin
        # checking variance, correlation length, scaling exponent
        for r in rand(1000)
            logcov = Log()
            @test typeof(logcov)<:SingularCovariance
            @test logcov(0) == Inf
            @test logcov(1) == 0
            r = min(r, 1)
            @test logcov(r) == log(1/abs(r)) 
        end
    end
    
end