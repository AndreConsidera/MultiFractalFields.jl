@recipe function f(gf::GaussianField)
    xlabel --> "x"
    ylabel --> "Field"
    lab --> "Gaussian"
    framestyle --> :box
    gf.torus.r, sample(gf)
end

@recipe function f(mf::MultiFractalField)
    xlabel --> "x"
    ylabel --> "Field"
    lab --> "multifractal-γ = $(mf.γ) "
    framestyle --> :box
    mf.torus.r, sample(mf)
end