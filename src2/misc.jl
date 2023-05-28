include("normevans.jl")
include("torus.jl")
include("covariances.jl")
include("noises.jl")
include("fields.jl")

using FFTW
using Distributions
using Plots
import StatsBase: sample 
import Random: seed!  


methods(sample)
N=2^15
η = 1e-5
tor = Torus(N,η)
l = Linear(2/3)
lg = Log()
gf = GaussianField(lg, tor)
mf = MultifractalField(l, gf, tor)


function sample(mf::MultifractalField)
    gff = sample(mf.gf)
    g1 = UnitaryWhiteNoise(gf.tor)
    g2 = UnitaryWhiteNoise(gf.tor)

    irfft(gf.Lk .* noise.wk, length(tor.r)) * length(tor.r)  
end


function sample(gf::GaussianField, seed::Int)  
    seed!(seed)
    noise = UnitaryWhiteNoise(gf.tor)
    irfft(gf.Lk .* noise.wk, length(tor.r)) * length(tor.r)  
end

function sample(gf::GaussianField)  
    noise = UnitaryWhiteNoise(gf.tor)
    irfft(gf.Lk .* noise.wk, length(tor.r)) * length(tor.r)  
end


u=sample(gf)

plot(tor.r,u)



using StatsBase
import Random



function covmat(cov::Covariance, x::AbstractVector , y::AbstractVector)
    C = zeros(eltype(cov), length(x), length(y))
    for (i, x) in enumerate(x), (j, y) in enumerate(y)  
        r = abs(x - y)
        C[i, j] = cov(r)
    end
    C == C' || throw(DomainError(C, "correlation matrix must be symmetric"))
    return C 
end

