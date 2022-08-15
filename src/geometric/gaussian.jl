export Gaussian

"""
    $(TYPEDEF)
Gaussian with unit standard deviation and flux.
By default if T isn't given, `Gaussian` defaults to `Float64`
"""
struct Gaussian{T} <: GeometricModel end
Gaussian() = Gaussian{Float64}()
radialextent(::Gaussian) = 5.0


@inline function intensity_point(::Gaussian{T}, x, y) where {T}
    return exp(-(x^2 + y^2) / 2) / 2π
end

@inline function visibility_point(::Gaussian{T}, u, v, args...) where {T}
    return exp(-2π^2 * (u^2 + v^2)) + zero(T)im
end