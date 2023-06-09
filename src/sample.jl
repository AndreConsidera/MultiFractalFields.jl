"""
    sample(f<:Field)

Sample from a given field `f`. 

Samples are generated by stochastic convolution in Fourier space.

"""
function sample end

# ----------------
# IMPLEMENTATIONS
# ----------------

include("sample/gaussian.jl")
include("sample/gmc.jl")
include("sample/multifractal.jl")