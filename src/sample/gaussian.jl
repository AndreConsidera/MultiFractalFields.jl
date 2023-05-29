function sample(gf::GaussianField)  
    noise = UnitaryWhiteNoise(gf.torus)
    irfft(gf.Lk .* noise.wk, length(gf.torus.r)) * length(gf.torus.r)  
end

function sample(gf::GaussianField, noise::UnitaryWhiteNoise)  
    irfft(gf.Lk .* noise.wk, length(gf.torus.r)) * length(gf.torus.r)  
end

function sample(gf::GaussianField, seed::Int)  
    seed!(seed)
    noise = UnitaryWhiteNoise(gf.torus)
    irfft(gf.Lk .* noise.wk, length(gf.torus.r)) * length(gf.torus.r)  
end

