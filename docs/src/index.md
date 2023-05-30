### Installation
---
Run the following commands to be able to run the script below
```julia
julia> using Pkg
julia> Pkg.add("MultiFractalFields")
julia> Pkg.add("Plots")
```
---
### Basic Usage
---
Below is a basic script to generate multifractal fields using `MultiFractalFields.jl`. The theoretical background is the Gaussian Multiplicative Chaos theory.

This Julia package was used to generate the results of [this paper](https://arxiv.org/pdf/2305.09839.pdf).

```julia
using MultiFractalFields
using Plots

N = 2^15; η = 4π/N; γ = 0.4     # define the physical/numerical parameters

torus = Torus(N, η)
lincov = Linear(2/3)            # linear covariance with scaling exponent 2/3 
logcov = Log()                  # singular covariance for the gmc

mf = MultiFractalField(lincov, torus, logcov, γ)
plot(mf)
```
---
![fields](./assets/fig1c.png)

