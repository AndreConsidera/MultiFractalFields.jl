"""
    Field(kernel, noise, path)

Stochastic convolution of `kernel` agaisnt `noise` generates a `path` (sample) of a `Field`.
"""
struct Field{T1,T2} 
    ker::Kernel{T1}
    noise::T2
    path::Vector{Float64}
    function Field(ker::Kernel{T1}, noise::T2) where {T1, T2}
        path = realization(ker, noise)  
        new{T1, T2}(ker, noise, path)  
    end
end

#type aliases for semantics and convenience  
const GaussianField = Field{T1, <:UnitaryWhiteNoise} where T1
const MultiFractalField = Field{T1, <:GmcNoise} where T1

#Interface
Base.length(f::Field) = Base.length(f.path)
realization(f::Field) = f.path
η_scale(f::Field) = f.ker.torus.η
grid(f::Field) = f.ker.torus.r
η_grid(f::Field) = f.ker.torus.rη
kernel(f::Field) = f.ker
noise(f::Field) = f.noise
model(f::Field) = f.ker.model
