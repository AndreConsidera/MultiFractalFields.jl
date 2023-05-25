"""
    normevans(x::Real, η::Real)

1D norm on the torus regularized at scale η.
If η>0 then normevans(0 ,η)>0.

# Examples
```jldoctest
julia> η = 0.1; normevans(0, η)
0.05

julia> η = 0.; normevans(0, η)
0.0
```
"""
function normevans(x::Real, η::Real)
    xmod = rem2pi(x, RoundNearest)
    tmp = abs(xmod)
    if η <= 0.
        return tmp
    else
        return 0.5(tmp^2/η + η )*(tmp <= η) + tmp * (tmp > η)
    end 
end