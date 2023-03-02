[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://EHTJulia.github.io/EHTModels.jl/dev/)
[![Build Status](https://github.com/EHTJulia/EHTModels.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/EHTJulia/EHTModels.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/EHTJulia/EHTModels.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/EHTJulia/EHTModels.jl)

# EHTModels
This Julia package aims to provide a generic interface to handle various type of parametrized intensity models for radio and optical interfeometric data sets (in particular in the emphasis of VLBI data sets).

The conceptial idea of the interface is largely based on the Lindy Blackburn's ([@lindybackburn](https://github.com/lindyblackburn)) python library [modmod](https://github.com/lindyblackburn/modmod), which allows:
- to compose a generic and hybrid model of various parameterized models including geometric and more generic pixeltized image models through basic primitives and transformations.
- to have analytic or numerical correspondence between image and fourier domain.
- delayed evaluation of image or uv products of a model through computational graph.

This package is a partial fork (or purge) of the Paul Tiede's ([@ptiede](https://github.com/ptiede)) Julia package [Comrade.jl](https://github.com/ptiede/Comrade.jl), implementing the above interface for the parameterized model. The pure Julia imprementation of parametrized models offer efficient integration of these functions into various inference packages available in Julia.

## Installation
Assuming that you already have Julia correctly installed, it suffices to import EHTModels.jl in the standard way:

```julia
using Pkg
Pkg.add("EHTModels")
```

## Documentation
The documentation is in preparation, but docstrings of available functions are listed for the [latest](https://ehtjulia.github.io/EHTModels.jl/dev) version available. The stable version has not been released. 


## Acknowledgement
The development of this package has been finantially supported by the following programs.
- v0.1.0 - v0.1.2: [ALMA North American Development Study Cycle 8](https://science.nrao.edu/facilities/alma/science_sustainability/alma-develop-history), National Radio Astronomy Observatory (NRAO), USA

The National Radio Astronomy Observatory is a facility of the National Science Foundation operated under cooperative agreement by Associated Universities, Inc.
