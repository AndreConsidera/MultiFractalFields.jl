using Documenter, .MultiFractalFields


DocMeta.setdocmeta!(MultiFractalFields, :DocTestSetup, :(using MultiFractalFields); recursive=true)

makedocs(
    modules=[MultiFractalFields],
    authors="Andre Considera",
    #repo="https://github.com/PieterjanRobbe/MultiFractalFields.jl/blob/{commit}{path}#{line}",
    sitename="MultiFractalFields.jl",
    format = Documenter.HTML(
        prettyurls = get(ENV, "CI", "false") == "true",
        #canonical="https://PieterjanRobbe.github.io/MultiFractalFields.jl",
        edit_link="main",
        assets=String[],
    ),
    pages = [
        "Home" => "index.md",
        #"Tutorial" => "tutorial.md",
        "API" => "API.md"
    ],
    checkdocs=:exports
)

#deploydocs(
#    repo = "github.com/PieterjanRobbe/MultiFractalFields.jl",
#    devbranch="main",
#)
