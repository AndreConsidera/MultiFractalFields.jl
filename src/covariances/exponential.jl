"""
    Exponential(ξ, [λ = 1], [σ² = 1])

Exponential covariance function with scaling exponent `ξ`, correlation length `λ` and variance `σ²`.

It is defined as `` C(r)= \\sigma^2  e^{-\\left(\\frac{r}{\\lambda}\\right)^{\\xi}}``.

# Examples 

```jldoctest
julia> expcov = Exponential(0.5, 1.5, 3)
Exponential{Float64}(ξ=0.5, λ=1.5, σ²=3.0)

julia> expcov(0)
3.0

julia> expcov(1.5) == 3/ℯ
true
```
"""
struct Exponential{T}<:Covariance{T}
    ξ::T
    λ::T
    σ²::T
    function Exponential{T}(ξ::T, λ::T, σ²::T) where T
        ξ >= 0 || throw(DomainError(ξ, "scaling exponent of exponential covariance cannot be negative"))
        λ > 0 || throw(DomainError(λ, "correlation length λ of exponential covariance cannot be negative or zero"))
        σ² > 0 || throw(DomainError(σ², "variance σ² of exponential covariance cannot be negative or zero"))
        new{T}(ξ, λ, σ²)
    end
end

# calling method 
(e::Exponential)(r::Real) = e.σ² * exp(-(abs(r)/e.λ)^e.ξ)

Exponential(ξ::T1, λ::T2, σ²::T3) where {T1, T2, T3} = Exponential{promote_type(T1, T2, T3)}(promote(ξ, λ, σ²)...)

#default
Exponential(ξ::T1; λ::Real=1.0, σ²::Real=1.0) where T1 = Exponential{promote_type(typeof(ξ), typeof(λ), typeof(σ²))}(promote(ξ, λ, σ²)...)
