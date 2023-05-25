"""
    Model
    
Supertype for the models of the covariance functions.
"""
abstract type AbstractModel end

# ----------------
# IMPLEMENTATIONS
# ----------------

include("models/covariance.jl")
include("models/singular.jl")
include("models/generic.jl")
