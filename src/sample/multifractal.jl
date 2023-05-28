function sample(mf::MultifractalField)
    Y = GaussianField(mf.scov,mf.tor)
    σ_sq = 2*sum(abs.(Y.Lk[2:end]).^2)
    g1 = UnitaryWhiteNoise(mf.tor)
    g1_x = irfft(g1.wk, length(mf.tor.r))
    gmc_x = g1_x .* exp.(mf.γ .* sample(Y) .- mf.γ^2 .* σ_sq)
    gmc_k = rfft(gmc_x)
    irfft(mf.Lk .* gmc_k, length(mf.tor.r)) * length(mf.tor.r)
end

function sample(mf::MultifractalField, g1::UnitaryWhiteNoise, g2::UnitaryWhiteNoise)
    Y = GaussianField(mf.scov, mf.tor)
    σ_sq = 2*sum(abs.(Y.Lk[2:end]).^2)
    g1_x = irfft(g1.wk, length(mf.tor.r))
    gmc_x = g1_x .* exp.(mf.γ .* sample(Y, g2) .- mf.γ^2 .* σ_sq)
    gmc_k = rfft(gmc_x)
    irfft(mf.Lk .* gmc_k, length(mf.tor.r)) * length(mf.tor.r)
end
