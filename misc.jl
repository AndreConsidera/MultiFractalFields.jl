using MultiFractalFields
using Plots

torus = Torus(2^15, 1e-2)
l = Linear(2/3)
lg = Log()
mf = MultifractalField(l, torus, lg, 0.4)
gf = GaussianField(l,torus)

methodswith(mf)
u=sample(mf)
plot(mf.tor.r,u)
