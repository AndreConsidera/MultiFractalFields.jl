# Examples

Some examples on how to use `MultiFractalFields`.

    
    using MultiFractalFields
    using Plots
    
    N = 2^16; η = 4pi/N ; γ = 0.4
    
    torus = Torus(N, η)
    cov = Linear(2/3)  #piecewise covariance with scaling exponent 2/3 
    logcov = Log()     #singular covariance  for the gmc
    
    mf = MultifractalField(cov, torus, logcov, γ)
    plot(mf)
    

