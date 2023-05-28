struct Log{T}<:SingularCovariance{T}
    λ::T
    σ::T
    function Log{T}(λ::T, σ::T) where T
        λ > 0 || throw(DomainError(λ, "correlation length λ of log covariance cannot be negative or zero"))
        σ > 0 || throw(DomainError(σ, "variance σ of log covariance cannot be negative or zero"))
        new{T}(λ, σ)
    end
end

# calling method
(lg::Log)(r::Real) = log(lg.λ/r)

Log(λ::T2, σ::T3) where {T2, T3} = Log{promote_type(T2, T3)}(promote(λ, σ)...)

#default
Log(; λ::Real=1.0, σ::Real=Inf) = Log{promote_type(typeof(λ), typeof(σ))}(promote(λ, σ)...)