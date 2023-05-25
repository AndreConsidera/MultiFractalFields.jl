"""
    realization(ker::Kernel, noise::UnitaryWhiteNoise)

Produces a Gaussian random field
with covariance given by the `Kernel`.

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

julia> u = realization(pwker,g1)
65536-element Vector{Float64}:
 -0.24957500624428564
 -0.257099977098161
  ⋮
 -0.18338174440638833
 -0.21365166911871514
```
"""
function realization(ker::Kernel, noise::UnitaryWhiteNoise)
    return irfft(ker.Lk .* noise.wk, length(ker.cη)) * length(ker.cη)  
end