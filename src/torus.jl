"""
    ηtorus(N, η)

1D torus regularized at scale `η` with `N` grid points.
"""
struct ηtorus{T1<:Real, T2<:Real}
    r::Vector{T1}
    η::T2
    rη::Vector{T1}
    function ηtorus(N, η)
        r = range(-π, step=2π/N,length=N)
        rη = normevans.(r, η)
        new{eltype(r),typeof(η)}(r, η, rη)
    end
end