using EHTModel
using Documenter

DocMeta.setdocmeta!(EHTModel, :DocTestSetup, :(using EHTModel); recursive=true)

makedocs(;
    modules=[EHTModel],
    authors="Paul Tiede, Kazunori Akiyama",
    repo="https://github.com/EHTJulia/EHTModel.jl/blob/{commit}{path}#{line}",
    sitename="EHTModel.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://EHTJulia.github.io/EHTModel.jl",
        edit_link="main",
        assets=String[]
    ),
    pages=[
        "Home" => "index.md",
    ]
)

deploydocs(;
    repo="github.com/EHTJulia/EHTModel.jl",
    devbranch="main"
)
