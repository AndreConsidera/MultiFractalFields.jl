"""
    realization(ker::Kernel, noise::GmcNoise)

Produces a multifractal random field with anomalous scaling.

See also [`GmcNoise`]@ref.

# Examples
```jldoctest
julia> N=2^16
65536

julia> η = 1e-4
0.0001

julia> ξ =6/9
0.6666666666666666

julia> L = 1.
1.0

julia> p = [L, ξ]
2-element Vector{Float64}:
 1.0
 0.6666666666666666

julia> @. pwmodel(x, y, p) = 1. - (abs(x-y)/p[1])^(p[2])
pwmodel (generic function with 1 method)

julia> torus = ηtorus(N, η);

julia> pwker = Kernel(torus, pwmodel, p)
[ Info: model is a true covariance function with lowest eigenvalue 0.031548372988242965
Kernel{CovarianceModel{typeof(pwmodel), Float64}}

julia> g1 = UnitaryWhiteNoise(torus);

julia> γ = 0.4
0.4

julia> @.logmodel(x, y, p) =log(p[1]/abs(x-y))
logmodel (generic function with 1 method)

julia> logker = Kernel(torus,logmodel, p)
[ Info: model is a singular covariance function with variance = ∞
Kernel{SingularModel{typeof(logmodel), Float64}}
...

julia> g2 = UnitaryWhiteNoise(torus);

julia> Γ = GmcNoise(logker, g1, g2, γ)
GmcNoise{Float64, ComplexF64}
...

julia> v = realization(pwker, Γ)
65536-element Vector{Float64}:
 -0.192212717614121
 -0.18421552151735698
  ⋮
 -0.19553204405263364
 -0.20120885892055368
"""
function realization(ker::Kernel, noise::GmcNoise)
    return irfft(ker.Lk .* noise.wk, length(ker.cη)) * length(ker.cη)  
end