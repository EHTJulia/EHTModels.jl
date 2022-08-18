export Butterworth
export ButterworthFilter

@doc raw"""
    Butterworth{T, N}() where {T}
Butterwoth filter in the visibility domain, i.e. the fourier-domain profile
```math
    V_N(r) = \left[ 1 + \left( \frac{1}{r}\right)^{2N}  \right]^{-1/2}
```
i.e. a unit filtering length and unit flux filter.
By default if T isn't given, `Butterworth` defaults to `T=Float64`.
If futher N isn't given,  `Butterworth` defaults to `N=2`.
"""
struct Butterworth{T,N} <: AbstractModel end
Butterworth{N}() where {N} = Butterworth{Float64,N}()
Butterworth() = Butterworth{2}()

radialextent(::Butterworth{T,N}) where {T,N} = 4.0

@inline flux(::Butterworth{T,N}) where {T,N} = 1.0
@inline isprimitive(::Butterworth{T,N}) where {T,N} = IsPrimitive()
@inline visanalytic(::Butterworth{T,N}) where {T,N} = IsAnalytic()
@inline imanalytic(::Butterworth{T,N}) where {T,N} = NotAnalytic()

@inline function visibility_point(::Butterworth{T,N}, u, v, args...) where {T,N}
    rsq = u^2 + v^2
    return (1 + rsq^N)^(-0.5) + zero(T)im
end

function ButterworthFilter(
    umaj::Real,
    umin::Real=-1,
    ϕ::Real=0;
    n=2,
    ϕunit=deg
)
    # check θmaj
    if umaj <= 0
        @error "umaj must be positive"
    end

    # check θmin
    if umin > umaj
        @error "umaj must be larger than umin"
    end

    # Conversion factor for the angular scales
    θmaj_rad = 1 / umaj
    if umin < 0
        θmin_rad = θmaj_rad
    else
        θmin_rad = 1 / umin
    end

    # constract the model
    model = Butterworth{Float64,n}()

    # stretch the model if necesary
    if θmaj_rad != 1 || θmin_rad != 1
        model = stretched(model, θmaj_rad, θmin_rad)
    end

    # rotate the model if necesary
    if ϕ != 0
        # Unit conversion for the position angle
        if ϕunit == rad
            ϕ_rad = ϕ
        elseif ϕunit == deg
            ϕ_rad = deg2rad(ϕ)
        else
            ϕ_rad = ϕ * unitconv(ϕunit, rad)
        end

        # rotate model
        model = rotated(model, ϕ_rad)
    end

    return model
end