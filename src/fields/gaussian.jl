struct GaussianField<:Field
    cov#::C
    tor#::T
    Lk
    function GaussianField(cov, tor)
        Lk = spectral_sqrt(cov,tor)
        new(cov, tor, Lk)
    end
end