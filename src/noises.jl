abstract type AbstractNoise end

struct UnitaryWhiteNoise{T<:Complex}<:AbstractNoise
    wk::Vector{T}
    torus::Torus
    function UnitaryWhiteNoise(torus::Torus)
        n = div(length(torus.r), 2) + 1
        wk = (1/2^0.5) * (rand(Normal(0, 1), n) + im * rand(Normal(0, 1), n))
        new{eltype(wk)}(wk, torus)
    end
end

