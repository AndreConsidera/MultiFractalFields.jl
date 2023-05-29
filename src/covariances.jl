"""
    AbstractCovariance{T}

Supertype for all covariance functions (singular or not).

## Examples

```jldoctest
julia> Covariance{Float64}<:AbstractCovariance{Float64}
true

julia> SingularCovariance{Int64}<:AbstractCovariance{Int64}
true
```
"""
abstract type AbstractCovariance{T} end


"""
    Covariance{T}  

Supertype for 'true' (non-singular) covariance functions.

Non-singular means that the variance ``\\sigma^2 < \\infty``.

## Examples

```jldoctest
julia> Exponential{Float32}<:Covariance{Float32}
true

julia> Linear{Int16}<:Covariance{Int16}
true
```
"""
abstract type Covariance{T}<:AbstractCovariance{T} end


"""
    SingularCovariance{T}

Supertype for singular covariance functions. 

Singular means that the variance ``\\sigma^2 = \\infty``.

## Examples

```jldoctest
julia> Log{Float64}<:SingularCovariance{Float64}
true
```
"""
abstract type SingularCovariance{T}<:AbstractCovariance{T} end


# show fields of covariances
function Base.show(io::IO, cov::AbstractCovariance)
    n = nfields(cov)
    if n>0
        names = fieldnames(typeof(cov))  
        values = [getfield(cov, sym) for sym in names] 
        z = zip(names, values)
        #z1, = z
        print(io, typeof(cov))
        print(io, "(", first(z)[1], "=", first(z)[2])
        for (i, (name, val)) in enumerate(z)
            if i>1 
                print(io,", ", name, "=" , val) 
            end
        end
        print(io, ")")
    end
end

Base.eltype(::AbstractCovariance{T}) where T = T

# ----------------
# IMPLEMENTATIONS
# ----------------

include("covariances/linear.jl")
include("covariances/exponential.jl")
include("covariances/log.jl")

