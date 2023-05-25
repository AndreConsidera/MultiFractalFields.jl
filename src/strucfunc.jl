"""
    strucfunc(Field, order, nsamples)

Compute structure function of a random `Field` for a given `order`
using `nsamples` realizations.
"""
function strucfunc end

# ----------------
# IMPLEMENTATIONS
# ----------------

include("strucfunc/multifractal.jl")
include("strucfunc/gaussian.jl")