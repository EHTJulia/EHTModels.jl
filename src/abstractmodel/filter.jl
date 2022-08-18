export create_filter

"""
    create_filter(AbstractModel, θmaj, [θmin, ϕ]; [θunit, ϕunit]) => AbstractModel

Create a filter model by streaching and rotating the given input basemodel.

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
function create_filter(
    BaseModel,
    θmaj::Real,
    θmin::Real=-1,
    ϕ::Real=0;
    θunit=rad,
    ϕunit=deg
)::AbstractModel

    # check θmaj
    if θmaj <= 0
        @error "θmaj must be positive"
    end

    # check θmin
    if θmin > θmaj
        @error "θmaj must be larger than θmin"
    end

    # Conversion factor for the angular scales
    fθ_rad = unitconv(θunit, rad)

    # scale major axis and minor axis sizes
    θmaj_rad = θmaj * fθ_rad
    if θmin < 0
        θmin_rad = θmaj_rad
    else
        θmin_rad = θmin * fθ_rad
    end

    # constract the model
    model = BaseModel()

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