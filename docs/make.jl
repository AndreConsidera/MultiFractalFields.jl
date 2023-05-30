using Documenter
using MultiFractalFields


DocMeta.setdocmeta!(MultiFractalFields, :DocTestSetup, :(using MultiFractalFields); recursive=true)

makedocs(
    modules=[MultiFractalFields],
    authors="Andre Considera",
    repo="https://github.com/AndreConsidera/MultiFractalFields.jl/blob/{commit}{path}#{line}",
    sitename="MultiFractalFields",
    format = Documenter.HTML(),
    pages = [
        "Home" => "index.md",
        "API" => "API.md"
    ],
    checkdocs=:exports
)

deploydocs(
    repo = "github.com/AndreConsidera/MultiFractalFields.jl.git",
)
