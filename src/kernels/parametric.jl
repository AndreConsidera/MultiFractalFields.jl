"""
   Kernel{T}(ηtorus, f, p)

Kernels for performing stocahstic convolution
parametrized by the type of the underlying model
for the covariance.

The model has functional form `f(x, y, p)` and parameters `p`.

See also [`ηtorus`]@ref.
"""
struct Kernel{T}<:AbstractKernel
    model::T
    cη::Vector{Float64}
    ck::Vector{ComplexF64}
    Lη::Vector{Float64}
    Lk::Vector{ComplexF64}
    Lη²::Vector{Float64}
    torus::ηtorus
    function Kernel(t::ηtorus, f::T, p::Vector) where T
        if isinf(f(0, 0, p))
            @info "model is a singular covariance function with variance = ∞"
            model = SingularModel(f, p)
        elseif !isinf(f(0, 0, p)) 
            iter = range(t.r[1], t.r[1] + p[1], length=100)
            covmat = [f(x, y, p) for x in iter, y in iter]
            eig = LinearAlgebra.eigmin(covmat)
            if eig >= 0 & LinearAlgebra.issymmetric(covmat) & !isinf(f(0, 0, p))
                @info "model is a true covariance function with lowest eigenvalue $eig"
                model = CovarianceModel(f, p)
            else
                @error "model is not a covariance function, lowest eigenvalue is $eig.\nPerhaps a problem with the model parameters?"
                model = GenericModel(f, p)
            end
        end

        cη = model(t.rη, 0., p)
        ck = rfft(copy(cη))./length(t.r)
        Lk = sqrt.(abs.(copy(ck)))
        Lη = irfft(copy(Lk), length(t.r)) .* length(t.r)
        Lη² = fftshift(irfft(Lk.^2, length(t.r))) .* length(t.r)
        new{typeof(model)}(model, cη, ck, Lη, Lk, Lη², t)
    end
end

#interface
Base.length(ker::Kernel) = Base.length(ker.torus.r)
klength(ker::Kernel) = Base.length(ker.Lk)
η_scale(ker::Kernel) = ker.torus.η
grid(ker::Kernel) = ker.torus.r
η_grid(ker::Kernel) = ker.torus.rη
η_cov(ker::Kernel) = ker.cη
Base.:^(ker::Kernel, p::Int) = p==2 ? ker.Lη² : p==1 ? ker : error("not defined") 
model(ker::Kernel) = ker.model