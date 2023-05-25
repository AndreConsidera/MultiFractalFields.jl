"""
   CovarianceModel(f, p)

Model for a true covariance function with functional form `f(x, y, p)` and parameters `p`.
Can be applied directly as `model`(x, y ,p).
 
Apllying `f(x, y, p)` results in a positive semi-definite matrix.
"""
struct CovarianceModel{T1<:Function, T2<:Union{Real, Complex}}<:AbstractModel
    f::T1
    p::Vector{T2}
end

(model::CovarianceModel)(x, y, p)  = model.f(x, y, p)