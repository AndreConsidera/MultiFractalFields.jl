"""
    SingularModel(f, p)

Model for singular covariance function with variance = ∞.
Mostly used when computing Gaussian Multiplicative Chaos.    
Go to https://arxiv.org/abs/1305.6221 for a review article
by Rhodes and Vargas.

Can be applied directly as `model`(x, y ,p).
"""
struct SingularModel{T1<:Function, T2<:Union{Real, Complex}}<:AbstractModel
    f::T1
    p::Vector{T2}
end

(model::SingularModel)(x, y, p)  = model.f(x, y, p)