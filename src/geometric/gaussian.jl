export EllipticalGaussian
export CircularGaussian
export Gaussian
export GaussianFilter


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
    return create_filter(Gaussian, θmaj * fwhm2σ, θmin * fwhm2σ, ϕ, θunit=θunit, ϕunit=ϕunit)
end

"""
    EllipticalGaussian(F, θmaj, [θmin, ϕ, x0, y0]; [θunit, ϕunit])

Create an elliptical Gaussian.

Args:
- `F::Real`:
    The total flux desnity of the Gaussian.
- `θmaj::Real`:
    The major-axis FWHM size of the Gaussian.
- `θmin::Real`:
    The minor-axis FWHM size of the Gaussian. If `θmin < 0`, then
    `θmin = θmax` (i.e. circular Gaussian). Default to -1.
- `ϕ::Real`:
    The position angle of the Gausian. Default to 0.
- `x0, y0::Real`:
    The centoral position in the unit of θunit. Default to 0.
- `θunit::Unitful`:
    The unit for `θmaj`, `θmin`, `x0` and `y0`. Default: `θunit=rad`.
- `ϕunit::Unitful`:
    The unit for `ϕ`. Default: `ϕ=deg`.
"""
function EllipticalGaussian(F::Real, θmaj::Real, θmin::Real=-1, ϕ::Real=0, x0::Real=0, y0::Real=0; θunit=rad, ϕunit=deg)
    g = create_filter(Gaussian, θmaj * fwhm2σ, θmin * fwhm2σ, ϕ, θunit=θunit, ϕunit=ϕunit)

    if F != 1.0
        g = g * F
    end

    if abs(x0) + abs(y0) != 0.0
        fθ_rad = unitconv(θunit, rad)
        g = shifted(g, x0 * fθ_rad, y0 * fθ_rad)
    end

    return g
end


"""
    CircularGaussian(F, θmaj, [x0, y0]; [θunit, ϕunit])

Create an circular Gaussian.

Args:
- `F::Real`:
    The total flux desnity of the Gaussian.
- `θfwhm::Real`:
    The FWHM size of the Gaussian.
- `x0, y0::Real`:
    The centoral position in the unit of θunit. Default to 0.
- `θunit::Unitful`:
    The unit for `θ`, `x0` and `y0`, respectively. 
    Default: `θunit=rad`.
"""
function CircularGaussian(F::Real, θfwhm::Real, x0::Real=0, y0::Real=0; θunit=rad)
    g = create_filter(Gaussian, θfwhm * fwhm2σ, -1, 0, θunit=θunit)

    if F != 1.0
        g = g * F
    end

    if abs(x0) + abs(y0) != 0.0
        fθ_rad = unitconv(θunit, rad)
        g = shifted(g, x0 * fθ_rad, y0 * fθ_rad)
    end

    return g
end