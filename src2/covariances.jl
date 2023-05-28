abstract type AbstractCovariance{T} end
abstract type Covariance{T}<:AbstractCovariance{T} end
abstract type SingularCovariance{T}<:AbstractCovariance{T} end

struct Exponential{T}<:Covariance{T}
    λ::T
    σ::T
    ξ::T
    function Exponential{T}(λ::T, σ::T, ξ::T) where T
        λ > 0 || throw(DomainError(λ, "correlation length λ of exponential covariance cannot be negative or zero"))
        σ > 0 || throw(DomainError(σ, "standard deviation σ of exponential covariance cannot be negative or zero"))
        ξ >= 0 || throw(DomainError(ξ, "scaling exponent of exponential covariance cannot be negative"))
        new{T}(λ, σ, ξ)
    end
end

# calling method 
(e::Exponential)(r::Real) = e.σ * exp(-(r/e.λ)^e.ξ)

Exponential(ξ::T1, λ::T2, σ::T3) where {T1, T2, T3} = Exponential{promote_type(T1, T2, T3)}(promote(ξ, λ, σ)...)

#default
Exponential(ξ::T1; λ::Real=1.0, σ::Real=1.0) where T1 = Exponential{promote_type(T1, typeof(λ), typeof(σ))}(promote(λ, σ, ξ)...)


struct Linear{T}<:Covariance{T}
    λ::T
    σ::T
    ξ::T
    function Linear{T}(λ::T, σ::T, ξ::T) where T
        λ > 0 || throw(DomainError(λ, "correlation length λ of linear covariance cannot be negative or zero"))
        σ > 0 || throw(DomainError(σ, "standard deviation σ of linear covariance cannot be negative or zero"))
        ξ >= 0 || throw(DomainError(ξ, "scaling exponent of linear covariance cannot be negative"))
        new{T}(λ, σ, ξ)
    end
end

# calling method
(l::Linear)(r::Real) = max(l.σ * (1 - (r/l.λ)^l.ξ), zero(r))

Linear(λ::T1, σ::T2, ξ::T3) where {T1, T2, T3} = Linear{promote_type(T1, T2, T3)}(promote(λ, σ, ξ)...)

#default
Linear(ξ::T1; λ::Real=1.0, σ::Real=1.0) where T1 = Linear{promote_type(T1, typeof(λ), typeof(σ))}(promote(λ, σ, ξ)...)

Base.eltype(::Covariance{T}) where T = T

struct Log{T}<:SingularCovariance{T}
    λ::T
    σ::T
    function Log{T}(λ::T, σ::T) where T
        λ > 0 || throw(DomainError(λ, "correlation length λ of exponential covariance cannot be negative or zero"))
        σ > 0 || throw(DomainError(σ, "standard deviation σ of exponential covariance cannot be negative or zero"))
        new{T}(λ, σ)
    end
end

# calling method
(lg::Log)(r::Real) = log(lg.λ/r)

Log(λ::T2, σ::T3) where {T2, T3} = Log{promote_type(T2, T3)}(promote(λ, σ)...)

#default
Log(; λ::Real=1.0, σ::Real=Inf) = Log{promote_type(typeof(λ), typeof(σ))}(promote(λ, σ)...)

Base.eltype(::SingularCovariance{T}) where T = T