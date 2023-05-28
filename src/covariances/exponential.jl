struct Exponential{T}<:Covariance{T}
    λ::T
    σ::T
    ξ::T
    function Exponential{T}(λ::T, σ::T, ξ::T) where T
        λ > 0 || throw(DomainError(λ, "correlation length λ of exponential covariance cannot be negative or zero"))
        σ > 0 || throw(DomainError(σ, "variance σ² of exponential covariance cannot be negative or zero"))
        ξ >= 0 || throw(DomainError(ξ, "scaling exponent of exponential covariance cannot be negative"))
        new{T}(λ, σ, ξ)
    end
end

# calling method 
(e::Exponential)(r::Real) = e.σ * exp(-(r/e.λ)^e.ξ)

Exponential(ξ::T1, λ::T2, σ::T3) where {T1, T2, T3} = Exponential{promote_type(T1, T2, T3)}(promote(ξ, λ, σ)...)

#default
Exponential(ξ::T1; λ::Real=1.0, σ::Real=1.0) where T1 = Exponential{promote_type(T1, typeof(λ), typeof(σ))}(promote(λ, σ, ξ)...)
