"""
    strucfunc(f::GaussianField, order::Integer, nsamples::Integer) 

Structure functions for Gaussian random field `f`.
"""
function strucfunc(f::GaussianField, order::Integer, nsamples::Integer) 
    @assert ispow2(length(f.ker.torus.r)) "spatial resolution must be a power of 2"
    r0s = 2 .^[i for i in 0:floor(log2(length(f.ker.torus.r))) - 1]
    dr = 2π/length(f.ker.torus.r)
    l = r0s * dr
    
    sptmp = zeros(length(r0s), nsamples)
    sp_abstmp = copy(sptmp)
    sp = zeros(length(r0s))
    sp_abs = copy(sp)
    
    for k in 1:nsamples
        noise = UnitaryWhiteNoise(f.ker.torus)
        u = realization(f.ker, noise)
        for (i, h) in enumerate(r0s)
            δv = circshift(u,-h) - u
            sptmp[i, k] = mean(δv.^order)
            sp_abstmp[i, k] = mean(abs.(δv).^order)
        end
    end
    sp = mean(sptmp, dims = 2)[1:end]
    sp_abs = mean(sp_abstmp, dims = 2)[1:end]
    return sp_abs, sp, l
end