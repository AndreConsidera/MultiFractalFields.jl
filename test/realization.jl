@testset "Realization" begin
    # Parseval identity and zero mean
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

    #piecewiese kernel
    M = 1000
    energy_x = zeros(M)
    energy_k = zeros(M)
    A = zeros(M)
    for γ in 0:0.1:0.6
        for i in 1:M
            g1 = UnitaryWhiteNoise(torus)
            g2 = UnitaryWhiteNoise(torus)
            Γ = GmcNoise(logker, g1 , g2, γ);
            u = realization(pwker, Γ);
            energy_k[i] = 2sum(abs.(Γ.wk[2:end] .* pwker.Lk[2:end]).^2) .+ abs.(Γ.wk[1] .* pwker.Lk[1]).^2
            energy_x[i] = mean(abs.(u).^2)
            A[i] = mean(u)
        end
         @test isapprox(mean(A), 0.,atol=1e-1)
         @test isapprox(mean(energy_x), mean(energy_k), atol=1e-1)
    end
    
    #exponential kernel
    M = 1000
    energy_x = zeros(M)
    energy_k = zeros(M)
    A = zeros(M)
    for γ in 0:0.1:0.6
        for i in 1:M
            g1 = UnitaryWhiteNoise(torus)
            g2 = UnitaryWhiteNoise(torus)
            Γ = GmcNoise(logker, g1 , g2, γ);
            u = realization(expker, Γ);
            energy_k[i] = 2sum(abs.(Γ.wk[2:end] .* expker.Lk[2:end]).^2) .+ abs.(Γ.wk[1] .* expker.Lk[1]).^2
            energy_x[i] = Statistics.mean(abs.(u).^2)
            A[i] = Statistics.mean(u)
        end
         @test isapprox(Statistics.mean(A), 0.,atol=1e-1)
         @test isapprox(Statistics.mean(energy_x), Statistics.mean(energy_k), atol=1e-1)
    end
end