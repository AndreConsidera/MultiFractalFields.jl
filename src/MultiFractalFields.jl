module MultiFractalFields

    using FFTW
    using Distributions
    using LinearAlgebra
    using RecipesBase
    
    import Base: ^
    
    export Field, GaussianField, MultiFractalField, TrivialGmcNoise, TrivialMultiFractalField
    export AbstractKernel, Kernel, GenericModel, SingularModel, CovarianceModel
    export UnitaryWhiteNoise, GmcNoise, AbstractNoise
    export realization
    export ηtorus
    export normevans
    export strucfunc
    export η_scale, grid, η_grid, η_cov, klength, kernel, noise, model
    
    include("normevans.jl")
    include("torus.jl")
    include("models.jl")
    include("kernels.jl")
    include("noises.jl")
    include("realization.jl")
    include("field.jl")
    include("plotrecipes/recipes.jl")
    include("strucfunc.jl")
end 
