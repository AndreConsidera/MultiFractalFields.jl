"""
    GenericModel(f, p)

Fallback for a model which is not a covariance nor singular.
Typically arises due to erros in model parameters.

Can be applied directly as `model`(x, y ,p).
"""

struct GenericModel{T1<:Function, T2<:Union{Real, Complex}}<:AbstractModel
    f::T1
    p::Vector{T2}
end

(model::GenericModel)(x, y, p)  = model.f(x, y, p)

