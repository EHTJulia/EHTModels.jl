export Gaussian, GaussianFilter

"""
    $(TYPEDEF)
Gaussian with unit standard deviation and flux.
By default if T isn't given, `Gaussian` defaults to `Float64`
"""
struct Gaussian{T} <: GeometricModel end
Gaussian() = Gaussian{Float64}()
radialextent(::Gaussian{T}) where {T} = 5.0


@inline function intensity_point(::Gaussian{T}, x, y) where {T}
    return exp(-(x^2 + y^2) / 2) / 2π
end

@inline function visibility_point(::Gaussian{T}, u, v, args...) where {T}
    return exp(-2π^2 * (u^2 + v^2)) + zero(T)im
end

"""
    GaussianFilter(θmaj, [θmin, ϕ]; [θunit, ϕunit])

Create an elliptical Gaussian filter with the total flux density of unity
centered at the origin.

Args:
- `θmaj::Real`:
    The major-axis FWHM size of the Gaussian.
- `θmin::Real`:
    The minor-axis FWHM size of the Gaussian. If `θmin < 0`, then
    `θmin = θmax` (i.e. circular Gaussian). Default to -1.
- `ϕ::Real`:
    The position angle of the Gausian. Default to 0.
- `θunit, ϕunit::Unitful`:
    The unit for `θmaj` & `θmin` and `ϕ`, respectively. 
    Default: `θunit=rad` and `ϕ=deg`.
"""
function GaussianFilter(θmaj::Real, θmin::Real=-1, ϕ::Real=0; θunit=rad, ϕunit=deg)
    return create_filter(Gaussian{T}, θmaj * σ2fwhm, θmin * σ2fwhm, ϕ, θunit=θunit, ϕunit=ϕunit)
end