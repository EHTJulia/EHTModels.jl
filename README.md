[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://EHTJulia.github.io/EHTModel.jl/stable/)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://EHTJulia.github.io/EHTModel.jl/dev/)
[![Build Status](https://github.com/EHTJulia/EHTModel.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/EHTJulia/EHTModel.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/EHTJulia/EHTModel.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/EHTJulia/EHTModel.jl)

# EHTModel
This Julia package aims to provide a generic interface to handle various type of parametrized intensity models for radio and optical interfeometric data sets (in particular in the emphasis of VLBI data sets).

The conceptial idea of the interface is largely based on the Lindy Blackburn's ([@lindybaclburn](https://github.com/lindyblackburn)) python library [modmod](https://github.com/lindyblackburn/modmod), which allows:
- to compose a generic and hybrid model of various parameterized models including geometric and more generic pixeltized image models through basic primitives and transformations.
- to have analytic or numerical correspondence between image and fourier domain.
- delayed evaluation of image or uv products of a model through computational graph.

This package is a partial folk (or purge) of the Paul Tiede's ([@ptiede](https://github.com/ptiede)) Julia package [Comrade.jl](https://github.com/ptiede/Comrade.jl), implementing the above interface for the parameterized model. The pure Julia imprementation of parametrized models offer efficient integration of these functions for various inference packages available in Julia science community.
