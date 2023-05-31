module MultiFractalFields

    using FFTW
    using Distributions
    using RecipesBase
    
    import Random: seed!

    export Field, GaussianField, MultiFractalField
    export Linear, Exponential, Log
    export sample
    export AbstractCovariance, Covariance, SingularCovariance
    export UnitaryWhiteNoise, AbstractNoise
    export Torus
    export normevans
    export GMC
    #export strucfunc
    
    include("normevans.jl")
    include("torus.jl")
    include("covariances.jl")
    include("spectral_sqrt.jl")
    include("noises.jl")
    include("gmc.jl")
    include("fields.jl")
    include("sample.jl")
    include("plotrecipes/fields.jl")
    #include("strucfunc.jl")
end 
