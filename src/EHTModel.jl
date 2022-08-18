module EHTModel
# import packages
using Accessors: @set
using DocStringExtensions
using EHTUtils
using NFFT


# include source codes
#   abstract models
include("abstractmodel/abstractmodel.jl")
include("abstractmodel/combinators.jl")
include("abstractmodel/filter.jl")
include("abstractmodel/modifiers.jl")

#   geometric models
include("geometric/geometric.jl")
include("geometric/rectangle.jl")
include("geometric/gaussian.jl")
include("geometric/disk.jl")

#   nongeometric filters
include("nongeometric/butterworth.jl")
end