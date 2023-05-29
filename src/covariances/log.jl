"""
    Log([λ = 1])

Logarithm covariance function with correlation length `λ` and variance `σ² = ∞`.

Used for generating the Gaussian Multiplicative Chaos.

It is defined as ``C(r) = \\log\\left(\\frac{\\lambda}{r}\\right) ``.

# Examples 

```jldoctest
julia> logcov = Log(1.5)
Log{Float64}(λ=1.5)

julia> logcov(0)
Inf

julia> logcov(1.5)
0.0
```
"""
struct Log{T}<:SingularCovariance{T}
    λ::T
    function Log{T}(λ::T) where T
        λ > 0 || throw(DomainError(λ, "correlation length λ of log covariance cannot be negative or zero"))
        new{T}(λ)
    end
end

# calling method
(lg::Log)(r::Real) = log(lg.λ/abs(r))

Log(λ::T) where T = Log{T}(λ)

#default
Log(; λ::Real=1.0) =  Log{typeof(λ)}(λ)