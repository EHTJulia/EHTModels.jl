export Rectangle
export RectangleFilter

@doc raw"""
    $(TYPEDEF)
Uniform rectangle geometrical model, i.e. the intensity profile
```math
    I(x,y) = \begin{cases} 1 & |x| < 0.5 and |y| < 0.5 \\ 0 & (otherwise) \end{cases}
```
i.e. a unit length and unit flux rectangle.
By default if T isn't given, `Rectangle` defaults to `Float64`
"""
struct Rectangle{T} <: GeometricModel end
Rectangle() = Rectangle{Float64}()
radialextent(::Rectangle{T}) where {T} = 2.0

@inline function intensity_point(::Rectangle{T}, x, y, args...) where {T}
    return abs(x) < 0.5 && abs(y) < 0.5 ? one(T) : zero(T)
end

@inline function visibility_point(::Rectangle{T}, u, v, args...) where {T}
    return sinc(pi * u) * sinc(pi * v) + zero(T)im
end


"""
    RectangleFilter(θmaj, [θmin, ϕ]; [θunit, ϕunit])

Create an rectangle filter with the total flux density of unity.

Args:
- `θmaj::Real`:
    The major-axis size of the rectangle.
- `θmin::Real`:
    The minor-axis size of the rectangle. If `θmin < 0`, then
    `θmin = θmax` (i.e. square). Default to -1.
- `ϕ::Real`:
    The position angle of the rectangle. Default to 0.
- `θunit, ϕunit::Unitful`:
    The unit for `θmaj` & `θmin` and `ϕ`, respectively. 
    Default: `θunit=rad` and `ϕ=deg`.
"""
function RectangleFilter(θmaj::Real, θmin::Real=-1, ϕ::Real=0; θunit=rad, ϕunit=deg)
    return create_filter(Rectangle, θmaj, θmin, ϕ, θunit=θunit, ϕunit=ϕunit)
end