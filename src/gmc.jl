struct GMC{G<:Real, S<:SingularCovariance}
    γ::G
    scov::S
    torus::Torus
end