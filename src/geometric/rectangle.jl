export Rectangle

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
