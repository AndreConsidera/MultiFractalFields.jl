"""
    Field

Supertype for `GaussianField` and `MultifractalField`. 

# Examples

```jldoctest
julia> GaussianField<:Field
true

julia> MultiFractalField<:Field
true
```
"""
abstract type Field end


# ----------------
# IMPLEMENTATIONS
# ----------------

include("fields/gaussian.jl")
include("fields/multifractal.jl")
