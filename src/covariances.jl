"""
    AbstractCovariance{T}

Supertype for all covariance functions (singular or not).
"""
abstract type AbstractCovariance{T} end

abstract type Covariance{T}<:AbstractCovariance{T} end

abstract type SingularCovariance{T}<:AbstractCovariance{T} end

Base.eltype(::AbstractCovariance{T}) where T = T

# ----------------
# IMPLEMENTATIONS
# ----------------

include("covariances/linear.jl")
include("covariances/exponential.jl")
include("covariances/log.jl")

