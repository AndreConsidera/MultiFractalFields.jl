@recipe function f(gf::GaussianField)
    xlabel --> "x"
    ylabel --> "Field"
    lab --> "Gaussian"
    framestyle --> :box
    gf.tor.r, sample(gf)
end

@recipe function f(mf::MultifractalField)
    xlabel --> "x"
    ylabel --> "Field"
    lab --> "multifractal-γ = $(mf.γ) "
    framestyle --> :box
    mf.tor.r, sample(mf)
end