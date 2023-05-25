"""
    realization(kernel, noise)

Perfoms a random realization of a 1D-velocity field 
via stochastic convolution of the `kernel` against `noise`.

Convolution is performed effeciently in Fourier space
by the FFTW.

Resulting field can be Gaussian or multifractal.
"""
function realization end

# ----------------
# IMPLEMENTATIONS
# ----------------

include("realization/gaussian.jl")
include("realization/multifractal.jl")