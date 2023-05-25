@recipe function f(t::ηtorus)
    xlabel --> "x"
    ylabel --> "rη"
    framestyle --> :box
    t.r, t.rη
end

@recipe function f(ker::Kernel)
    xlabel --> "r"
    ylabel --> "Cη "
    framestyle --> :box
    xlims --> [0, ker.model.p[1]]
    ylims --> [0, maximum(ker.cη)]
    xs = get(plotattributes, :xscale, :auto)
    lab --> ["Cη" "Lη²"]
    if xs!==:identity
        ker.torus.r[ker.torus.r.>0], [ker.cη[ker.torus.r.>0], ker.Lη²[ker.torus.r.>0]]
    else
        ker.torus.r, [ker.cη, ker.Lη²]
    end
end

@recipe function f(noise::GmcNoise)
    xlabel --> "x"
    ylabel --> "Gmc"
    framestyle --> :box
    noise.ker.torus.r, noise.wr
end

@recipe function f(gf::GaussianField)
    xlabel --> "x"
    ylabel --> "Field"
    lab --> "Gaussian"
    framestyle --> :box
    gf.ker.torus.r, gf.path
end

@recipe function f(mf::MultiFractalField)
    xlabel --> "x"
    ylabel --> "Field"
    lab --> "multifractal-γ = $(mf.noise.γ) "
    framestyle --> :box
    mf.ker.torus.r, mf.path
end