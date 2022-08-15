module EHTModel
# import packages
using Accessors: @set
using DocStringExtensions
using NFFT


# include source codes
#   abstract models
include("abstractmodel/abstractmodel.jl")
include("abstractmodel/modifiers.jl")
include("abstractmodel/combinators.jl")
#   geometric models
include("geometric/geometric.jl")
include("geometric/rectangle.jl")
include("geometric/gaussian.jl")
include("geometric/disk.jl")
#   image
end
