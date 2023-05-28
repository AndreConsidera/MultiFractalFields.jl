function normevans(x::Real, η::Real)
    xmod = rem2pi(x, RoundNearest)
    tmp = abs(xmod)
    if η <= 0.
        return tmp
    else
        return 0.5(tmp^2/η + η )*(tmp <= η) + tmp * (tmp > η)
    end 
end