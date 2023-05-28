# Examples

Some examples on how to use `MultiFractalFields`.

    ```julia
    using MultiFractalFields
    using Plots
    ```


A multifractal field is random field possesing anomalous scaling. 

```julia
N = 2^16; η = 4pi/N ; γ = 0.4
torus = Torus(N, η)
cov = Linear(2/3)  #piecewise covariance with scaling exponent 2/3 
logcov = Log()     #singular covariance  for the gmc
mf = MultifractalField(cov, torus, logcov, γ)
plot(mf)
```
<img src="assets/mf.jpg" alt="Multifractal Field" style="width:100%">