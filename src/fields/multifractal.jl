struct MultifractalField<:Field
    cov::Covariance
    tor::Torus
    scov::SingularCovariance
    γ::Float64
    Lk
    function MultifractalField(cov,tor,scov,γ)
        Lk = spectral_sqrt(cov, tor)
        new(cov,tor,scov,γ, Lk)
    end
end