struct Linear{T}<:Covariance{T}
    λ::T
    σ::T
    ξ::T
    function Linear{T}(λ::T, σ::T, ξ::T) where T
        λ > 0 || throw(DomainError(λ, "correlation length λ of linear covariance cannot be negative or zero"))
        σ > 0 || throw(DomainError(σ, "variance σ² of linear covariance cannot be negative or zero"))
        ξ >= 0 || throw(DomainError(ξ, "scaling exponent of linear covariance cannot be negative"))
        new{T}(λ, σ, ξ)
    end
end

# calling method
(l::Linear)(r::Real) = max(l.σ * (1 - (r/l.λ)^l.ξ), zero(r))

Linear(λ::T1, σ::T2, ξ::T3) where {T1, T2, T3} = Linear{promote_type(T1, T2, T3)}(promote(λ, σ, ξ)...)

#default
Linear(ξ::T1; λ::Real=1.0, σ::Real=1.0) where T1 = Linear{promote_type(T1, typeof(λ), typeof(σ))}(promote(λ, σ, ξ)...)
