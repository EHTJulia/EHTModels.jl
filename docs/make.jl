using SMILIModelBase
using Documenter

DocMeta.setdocmeta!(SMILIModelBase, :DocTestSetup, :(using SMILIModelBase); recursive=true)

makedocs(;
    modules=[SMILIModelBase],
    authors="Kazunori Akiyama",
    repo="https://github.com/EHTJulia/SMILIModelBase.jl/blob/{commit}{path}#{line}",
    sitename="SMILIModelBase.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://EHTJulia.github.io/SMILIModelBase.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/EHTJulia/SMILIModelBase.jl",
    devbranch="main",
)
