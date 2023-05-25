"""
   UnitaryWhiteNoise(ηtorus)

Brownian motion in the regularized torus.
Sampling takes place in Fourier space.
"""
struct UnitaryWhiteNoise{T<:Complex}<:AbstractNoise
    wk::Vector{T}
    torus::ηtorus
    function UnitaryWhiteNoise(t::ηtorus)
        n = div(length(t.r), 2) + 1
        wk = (1/2^0.5) * (rand(Normal(0, 1), n) + im * rand(Normal(0, 1), n))
        new{eltype(wk)}(wk, t)
    end
end