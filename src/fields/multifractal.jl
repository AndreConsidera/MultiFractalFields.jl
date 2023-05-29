"""
    MultiFractalField(cov, torus, scov, γ)

Multifractal random field with intermittency parameter `γ`.

`scov<:SingularCovariance` is necessary to generate the Gaussian Multiplicative Chaos.

# Examples

```jldoctest
julia> torus = Torus(100, 0.1)
Torus{Float64, Float64}(n=100,η=0.1)

julia> lincov = Linear(0.5)
Linear{Float64}(ξ=0.5, λ=1.0, σ²=1.0)

julia> MultiFractalField(lincov, torus, Log(), 0.4)
MultiFractalField(γ=0.4,cov=Linear{Float64}(ξ=0.5, λ=1.0, σ²=1.0),torus=Torus{Float64, Float64}(n=100,η=0.1))
```
"""
struct MultiFractalField<:Field
    cov::Covariance
    torus::Torus
    scov::SingularCovariance
    γ::Float64
    Lk
    function MultiFractalField(cov, torus, scov, γ)
        Lk = spectral_sqrt(cov, torus)
        new(cov, torus, scov, γ, Lk)
    end
end

function Base.show(io::IO, mf::MultiFractalField)
    cov = getfield(mf, :cov)
    torus = getfield(mf, :torus)
    γ = getfield(mf, :γ)
    print(io, typeof(mf), "(γ=", γ,"," ,"cov=",cov, ",", "torus=", torus ,")")
end