export Disk
export DiskFileter

@doc raw"""
    $(TYPEDEF)
Uniform disk geometrical model, i.e. the intensity profile
```math
    I(x,y) = \begin{cases} \pi^{-1} & x^2+y^2 < 1 \\ 0 & x^2+y^2 \geq 0 \end{cases}
```
i.e. a unit radius and unit flux disk.
By default if T isn't given, `Disk` defaults to `Float64`
"""
struct Disk{T} <: GeometricModel end
Disk() = Disk{Float64}()
radialextent(::Disk{T}) where {T} = 3.0

@inline function intensity_point(::Disk{T}, x, y, args...) where {T}
    r = x^2 + y^2
    return r < 1 ? one(T) / (π) : zero(T)
end

@inline function visibility_point(::Disk{T}, u, v, args...) where {T}
    ur = 2π * (hypot(u, v) + eps(T))
    return 2 * besselj1(ur) / (ur) + zero(T)im
end

"""
    DiskFilter(θmaj, [θmin, ϕ]; [θunit, ϕunit])

Create an elliptical Disk filter with the total flux density of unity
centered at the origin.

Args:
- `θmaj::Real`:
    The major-axis size of the disk.
- `θmin::Real`:
    The minor-axis size of the disk. If `θmin < 0`, then
    `θmin = θmax` (i.e. circular disk). Default to -1.
- `ϕ::Real`:
    The position angle of the elliptical disk. Default to 0.
- `θunit, ϕunit::Unitful`:
    The unit for `θmaj` & `θmin` and `ϕ`, respectively. 
    Default: `θunit=rad` and `ϕ=deg`.
"""
function DiskFilter(θmaj::Real, θmin::Real=-1, ϕ::Real=0; θunit=rad, ϕunit=deg)
    return create_filter(Disk, θmaj, θmin, ϕ, θunit=θunit, ϕunit=ϕunit)
end