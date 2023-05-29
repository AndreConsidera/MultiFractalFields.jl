@testset "Covariances and Fields" begin
    Torus(2^15, 1e-2)
    Linear(2/3)
    Exponential(1/3)
    Log()
    Linear(1,1.,2/3)
    Exponential(1,0.5,2/3)
    Log(2.5)
    MultiFractalField(Linear(2/3), Torus(2^15, 1e-2), Log(), 0.4)
    MultiFractalField(Exponential(1/3), Torus(2^15, 1e-2), Log(), 0.6)
    GaussianField(Exponential(1,0.5,2/3), Torus(2^15, 1e-2))
    
    mf = MultiFractalField(Linear(1,1.,2/3), Torus(2^15, 1e-2), Log(), 0.4)
    gf = GaussianField(Exponential(1,0.5,2/3), Torus(2^15, 1e-2))
    sample(gf)
    
    seed = 1234
    sample(gf,seed)
    sample(mf)
    g1 = UnitaryWhiteNoise(Torus(2^15, 1e-2))
    g2 = UnitaryWhiteNoise(Torus(2^15, 1e-2))
    sample(mf, g1, g2)

end
