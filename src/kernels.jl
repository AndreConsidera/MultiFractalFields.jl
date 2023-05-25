"""
    Kernel

Kernel to perform stochastic convolution
against different types of noises.
    
See also [`AbstractNoise`](@ref)
"""
abstract type AbstractKernel end

# ----------------
# IMPLEMENTATIONS
# ----------------

include("kernels/parametric.jl")