"""
    Torus(n, η)

1D torus regularized at scale `η` with `n` grid points.

## Examples

```jldoctest
julia> torus = Torus(100, 0.1)
Torus{Float64, Float64}(n=100,η=0.1)
```
"""
struct Torus{T1<:Real, T2<:Real}
    r::Vector{T1}
    η::T2
    rη::Vector{T1}
    n ::Int
    function Torus(n, η)
        r = range(-π, step=2π/n,length=n)
        rη = normevans.(r, η)
        new{eltype(r),typeof(η)}(r, η, rη, n)
    end
end

function Base.show(io::IO, torus::Torus)
    n = getfield(torus, :n)
    η = getfield(torus, :η)
    print(io, typeof(torus), "(n=",n, ",", "η=",η, ")")
end
