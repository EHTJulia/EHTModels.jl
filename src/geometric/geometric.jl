export GeometricModel

"""
    $(TYPEDEF)
A type that defines it is a geometric model. These are usually
primitive models, and are usually analytic in Fourier and the image domain.
As a result a user only needs to implement the following methods
- `visibility_point`
- `intensity_point`
- `radialextent`
Note that if the geometric model isn't **analytic** then the usual methods listed
in [`Comrade.AbstractModel`](@ref) for non-analytic models need to be implemented.
"""
abstract type GeometricModel <: AbstractModel end

@inline flux(::GeometricModel) = 1.0
@inline isprimitive(::GeometricModel) = IsPrimitive()
@inline visanalytic(::GeometricModel) = IsAnalytic()
@inline imanalytic(::GeometricModel) = IsAnalytic()