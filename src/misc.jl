include("normevans.jl")
include("torus.jl")
include("covariances.jl")
include("noises.jl")

using FFTW
using Distributions
using Plots
import StatsBase: sample 
import Random: seed!
include("fields.jl")



torus = Torus(2^15, 1e-2)
l = Linear(2/3)
lg = Log()
mf = MultifractalField(l, torus, lg, 0.4)
u=sample(mf)
plot(mf.tor.r,u)




using StatsBase
import Random


