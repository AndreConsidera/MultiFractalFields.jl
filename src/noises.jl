"""
    Noise

Noise process to generate different realizations of random velocity fields.
"""
abstract type AbstractNoise end

# ----------------
# IMPLEMENTATIONS
# ----------------

include("noises/unitarywhitenoise.jl")
include("noises/gmcnoise.jl")