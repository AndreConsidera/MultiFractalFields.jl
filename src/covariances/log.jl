struct Log{T}<:SingularCovariance{T}
    λ::T
    function Log{T}(λ::T) where T
        λ > 0 || throw(DomainError(λ, "correlation length λ of log covariance cannot be negative or zero"))
        new{T}(λ)
    end
end

# calling method
(lg::Log)(r::Real) = log(lg.λ/r)

Log(λ::T) where T = Log{T}(λ)

#default
Log(; λ::Real=1.0) =  Log{typeof(λ)}(λ)