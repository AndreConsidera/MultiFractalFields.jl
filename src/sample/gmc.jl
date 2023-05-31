function sample(gmc::GMC)
    gf = GaussianField(gmc.scov, gmc.torus)
    σ² = 2sum(abs.(gf.Lk[2:end]).^2)
    exp.(gmc.γ .* sample(gf) .- gmc.γ^2 .* σ²)
end

function sample(gmc::GMC, seed::Int)
    gf = GaussianField(gmc.scov, gmc.torus)
    σ² = 2sum(abs.(gf.Lk[2:end]).^2)
    exp.(gmc.γ .* sample(gf, seed) .- gmc.γ^2 .* σ²)
end