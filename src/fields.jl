"""
    Field

Supertype for `GaussianField` and `MultifractalField`. 
"""
abstract type Field end

function sample end

# ----------------
# IMPLEMENTATIONS
# ----------------

include("fields/gaussian.jl")
include("fields/multifractal.jl")
include("sample/gaussian.jl")
include("sample/multifractal.jl")