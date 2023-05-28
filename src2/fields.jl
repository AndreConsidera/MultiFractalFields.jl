abstract type Field end

struct GaussianField<:Field
    cov#::C
    tor#::T
    Lk
    function GaussianField(cov, tor)
        Lk = spectral_sqrt(cov,tor)
        new(cov, tor, Lk)
    end
end

struct MultifractalField<:Field
    cov::Covariance
    gf::GaussianField
    tor::Torus
    Lk
    function MultifractalField(cov,gf,tor)
        Lk = spectral_sqrt(cov,tor)
        new(cov, gf, tor, Lk)
    end
end


function spectral_sqrt(cov::AbstractCovariance{<:Any}, tor::Torus)
    cη = cov.(tor.rη)
    ck = rfft(copy(cη))./length(tor.r)
    Lk = sqrt.(abs.(copy(ck)))
end 


