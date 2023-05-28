function sample(gf::GaussianField)  
    noise = UnitaryWhiteNoise(gf.tor)
    irfft(gf.Lk .* noise.wk, length(gf.tor.r)) * length(gf.tor.r)  
end

function sample(gf::GaussianField, noise::UnitaryWhiteNoise)  
    irfft(gf.Lk .* noise.wk, length(gf.tor.r)) * length(gf.tor.r)  
end

function sample(gf::GaussianField, seed::Int)  
    seed!(seed)
    noise = UnitaryWhiteNoise(gf.tor)
    irfft(gf.Lk .* noise.wk, length(gf.tor.r)) * length(gf.tor.r)  
end

