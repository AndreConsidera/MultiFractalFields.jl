@testset "Field" begin
    # Multifractal is Gaussian when γ = 0
    N = 2^15
    η = 1/N
    ξ = 2/3
    L = 1
    p = [L, ξ]
    torus = ηtorus(N, η);

    @.pwmodel(x, y, p) = 1. - (abs(x-y)/p[1])^(p[2]) * ((abs(x-y)/p[1])<=p[1])
    @.expmodel(x, y, p) = exp(-(abs(x-y)/p[1])^(p[2]))
    @.logmodel(x, y, p) = log(p[1]/abs(x-y)) 
    pwker = Kernel(torus, pwmodel, p);
    expker = Kernel(torus, expmodel, p);
    logker = Kernel(torus, logmodel, p);
    
    for _ in 1:100
        g1 = UnitaryWhiteNoise(torus)
        g2 = UnitaryWhiteNoise(torus)
        γ = 0
        Γ = GmcNoise(logker, g1, g2, γ)
        mf = Field(pwker, Γ)
        gf = Field(pwker, g1)
        @test isapprox(gf.path, mf.path, atol=1e-12)
    end
end