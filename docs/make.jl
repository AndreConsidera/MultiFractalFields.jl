using Documenter
using MultiFractalFields


DocMeta.setdocmeta!(MultiFractalFields, :DocTestSetup, :(using MultiFractalFields); recursive=true)

makedocs(
    modules=[MultiFractalFields],
    authors="Andre Considera",
    repo="https://github.com/AndreConsidera/MultiFractalFields.jl/blob/{commit}{path}#{line}",
    sitename="MultiFractalFields.jl",
    format = Documenter.HTML(
        prettyurls = get(ENV, "CI", "false") == "true",
        canonical="https://AndreConsidera.github.io/MultiFractalFields.jl",
        edit_link="main",
        assets=String[],
    ),
    pages = [
        "Home" => "index.md",
        "API" => "API.md"
    ],
    checkdocs=:exports
)

deploydocs(
    repo = "github.com/AndreConsidera/MultiFractalFields.jl.git",
    
)
