using MultiFractalFields
using GaussianRandomFields
using Plots

N = 2^10
η = 1/N
ξ = 2/3
L = 1
p = [L, ξ]
γ = 0.0
torus = ηtorus(N, η);
@.pwmodel(x, y, p) = 1. - (abs(x-y)/p[1])^(p[2]) * ((abs(x-y)/p[1])<=p[1])
@.expmodel(x, y, p) = exp(-(abs(x-y)/p[1])^(p[2]))
@.logmodel(x, y, p) = log(p[1]/abs(x-y)) 
pwker = Kernel(torus, pwmodel, p);
expker = Kernel(torus, expmodel, p);
logker = Kernel(torus, logmodel, p);
g1 = UnitaryWhiteNoise(torus)
g2 = UnitaryWhiteNoise(torus)


cov = CovarianceFunction(1, Exponential(0.5))
pts = grid(expker)

m =10000
specdata=GaussianRandomFields.compute_analytic(cov,m,pts)
ef, ev = specdata.eigenfunc, specdata.eigenval 
A=zeros(N,m)
for i in 1:m
    σ_sq = 2*sum(abs.(logker.Lk[2:end]).^2)
    q = exp.(γ .* realization(logker, g2) .- γ^2 .* σ_sq)
    A[:,i] = q
end


ef[:,1]
size(ef)
size(A)
Γ.wr
f=zeros(N)
using Distributions
for i in 1:N
    f[i]=sum(ev[:].*ef[i,:].*A[i,:])
end
plot(torus.r,f)