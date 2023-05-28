module MultiFractalFields

    using FFTW
    using Distributions
    using LinearAlgebra
    using RecipesBase
    using Statistics

    import Base: ^
    
    export Field, GaussianField, MultifractalField
    #export sample
    export AbstractCovariance, Covariance, SingularCovariance
    export UnitaryWhiteNoise, AbstractNoise
    #export realization
    export Torus
    export normevans
    #export strucfunc
    #export η_scale, grid, η_grid, η_cov, klength, kernel, noise, model
    
    include("normevans.jl")
    include("torus.jl")
    include("covariances.jl")
   # include("kernels.jl")
    include("noises.jl")
    #include("realization.jl")
    include("fields.jl")
    #include("plotrecipes/recipes.jl")
    #include("strucfunc.jl")
end 
