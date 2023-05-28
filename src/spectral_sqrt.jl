function spectral_sqrt(cov::AbstractCovariance{<:Any}, tor::Torus)
    cη = cov.(tor.rη)
    ck = rfft(copy(cη))./length(tor.r)
    Lk = sqrt.(abs.(copy(ck)))
end 
