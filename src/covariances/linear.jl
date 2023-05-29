"""
    Linear(ξ, [λ = 1], [σ² = 1])

Linear covariance function with scaling exponent `ξ`, correlation length `λ` and variance `σ²`.

It is defined as ``C(r) = \\begin{cases} \\sigma^2 \\left(1 - \\displaystyle \\left(\\frac{r}{\\lambda}\\right)^{\\xi}\\right) & \\text{if }r ≤ \\lambda\\\\ 0 & \\text{if }r>\\lambda\\end{cases}``.

# Examples 

```jldoctest
julia> lincov = Linear(0.5, 1.5, 3)
Linear{Float64}(ξ=0.5, λ=1.5, σ²=3.0)

julia> lincov(0)
3.0

julia> lincov(1.5)
0.0
```
"""
struct Linear{T}<:Covariance{T}
    ξ::T
    λ::T
    σ²::T
    function Linear{T}(ξ::T, λ::T, σ²::T) where T
        ξ >= 0 || throw(DomainError(ξ, "scaling exponent of linear covariance cannot be negative"))
        λ > 0 || throw(DomainError(λ, "correlation length λ of linear covariance cannot be negative or zero"))
        σ² > 0 || throw(DomainError(σ², "variance σ² of linear covariance cannot be negative or zero"))
        new{T}(ξ, λ, σ²)
    end
end

# calling method
(l::Linear)(r::Real) = max(l.σ² * (1 - (abs(r)/l.λ)^l.ξ), zero(r))

Linear(ξ::T1, λ::T2, σ²::T3) where {T1, T2, T3} = Linear{promote_type(T1, T2, T3)}(promote(ξ, λ, σ²)...)

#default
Linear(ξ::T1; λ::Real=1.0, σ²::Real=1.0) where T1 = Linear{promote_type(typeof(ξ), typeof(λ), typeof(σ²))}(promote(ξ, λ, σ²)...)
