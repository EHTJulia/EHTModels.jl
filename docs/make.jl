using Pkg
ENV["PYTHON"]=""
Pkg.build("PyCall")
using PyPlot

using EHTModels
using Documenter

DocMeta.setdocmeta!(EHTModels, :DocTestSetup, :(using EHTModels); recursive=true)

makedocs(;
    modules=[EHTModels],
    authors="Paul Tiede, Kazunori Akiyama",
    repo="https://github.com/EHTJulia/EHTModels.jl/blob/{commit}{path}#{line}",
    sitename="EHTModels.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://EHTJulia.github.io/EHTModels.jl",
        edit_link="main",
        assets=String[]
    ),
    pages=[
        "Home" => "index.md",
    ]
)

deploydocs(;
    repo="github.com/EHTJulia/EHTModels.jl",
    devbranch="main"
)
