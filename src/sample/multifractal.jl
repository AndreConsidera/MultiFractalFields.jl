function sample(mf::MultiFractalField)
    Y = GaussianField(mf.scov,mf.torus)
    σ_sq = 2*sum(abs.(Y.Lk[2:end]).^2)
    g1 = UnitaryWhiteNoise(mf.torus)
    g1_x = irfft(g1.wk, length(mf.torus.r))
    gmc_x = g1_x .* exp.(mf.γ .* sample(Y) .- mf.γ^2 .* σ_sq)
    gmc_k = rfft(gmc_x)
    irfft(mf.Lk .* gmc_k, length(mf.torus.r)) * length(mf.torus.r)
end

function sample(mf::MultiFractalField, g1::UnitaryWhiteNoise, g2::UnitaryWhiteNoise)
    Y = GaussianField(mf.scov, mf.torus)
    σ_sq = 2*sum(abs.(Y.Lk[2:end]).^2)
    g1_x = irfft(g1.wk, length(mf.torus.r))
    gmc_x = g1_x .* exp.(mf.γ .* sample(Y, g2) .- mf.γ^2 .* σ_sq)
    gmc_k = rfft(gmc_x)
    irfft(mf.Lk .* gmc_k, length(mf.torus.r)) * length(mf.torus.r)
end
