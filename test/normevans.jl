@testset "Normevans" begin
    # periodicity
    η = range(0,1,length=100)
    x = range(-6pi, 6pi,length=100)
    for η in η, x in x
        @test isapprox(normevans(x, η), normevans(x + 2π, η), atol=1e-13)
    end
    
    # regularization
    for η in range(0,1,length=5000)
        @test normevans(0, η) == η/2
        @test isapprox(normevans(η, η), η; atol = 1e-13)
    end
end