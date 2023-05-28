abstract type Field end

struct GaussianField<:Field
    cov#::C
    tor#::T
    Lk
    function GaussianField(cov, tor)
        Lk = spectral_sqrt(cov,tor)
        new(cov, tor, Lk)
    end
end

function sample(gf::GaussianField, seed::Int)  
    seed!(seed)
    noise = UnitaryWhiteNoise(gf.tor)
    irfft(gf.Lk .* noise.wk, length(gf.tor.r)) * length(gf.tor.r)  
end

function sample(gf::GaussianField, noise::UnitaryWhiteNoise)  
    irfft(gf.Lk .* noise.wk, length(tor.r)) * length(tor.r)  
end

function sample(gf::GaussianField)  
    noise = UnitaryWhiteNoise(gf.tor)
    irfft(gf.Lk .* noise.wk, length(gf.tor.r)) * length(gf.tor.r)  
end



struct MultifractalField<:Field
    cov::Covariance
    tor::Torus
    scov::SingularCovariance
    γ::Float64
    Lk
    function MultifractalField(cov,tor,scov,γ)
        Lk = spectral_sqrt(cov, tor)
        new(cov,tor,scov,γ, Lk)
    end
end


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




function spectral_sqrt(cov::AbstractCovariance{<:Any}, tor::Torus)
    cη = cov.(tor.rη)
    ck = rfft(copy(cη))./length(tor.r)
    Lk = sqrt.(abs.(copy(ck)))
end 


