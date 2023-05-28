@testset "Covariances and Fields" begin
    torus = Torus(2^15, 1e-2)
    @test l = Linear(2/3)
    @test e = Exponential(1/3)
    @test lg = Log()
    @test Linear(1,1.,2/3)
    @test e2 = Exponential(1,0.5,2/3)
    @test Log(2.5)
    
    @test mf = MultifractalField(l, torus, lg, 0.4)
    @test MultifractalField(e, torus, lg, 0.6)
    @test gf = GaussianField(e2, torus)
    
    @test sample(gf)
    @test seed = 1234
    @test sample(gf,seed)
    @test sample(mf)
    @test g1 = UnitaryWhiteNoise(torus)
    @test g2 = UnitaryWhiteNoise(torus)
    @test sample(mf, g1, g2)

end