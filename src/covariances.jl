"""
    Abstract supertype for the covariance functions (singular or not).

# Examples
```jldoctest
julia> Linear{Float64}<:AbstractCovariance{Float64}
true

julia> Log{Int64}<:AbstractCovariance{Int64}
true
```
"""
abstract type AbstractCovariance{T} end



Base.eltype(::AbstractCovariance{T}) where T = T



abstract type Covariance{T}<:AbstractCovariance{T} end


abstract type SingularCovariance{T}<:AbstractCovariance{T} end

# ----------------
# IMPLEMENTATIONS
# ----------------

include("covariances/linear.jl")
include("covariances/exponential.jl")
include("covariances/log.jl")

