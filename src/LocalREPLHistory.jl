module LocalREPLHistory

HISTORY_FILE = ".julia_history"
GITIGNORE = ".gitignore"

function init()
    open("~/.julia/config/startup.jl", "a") do fp
        print(fp, """
using LocalREPLHistory
LocalREPLHistory.use_localhistoryfile()
""")
    end
end

function use_localhistoryfile(targetdir = pwd())
    if HISTORY_FILE in readdir(targetdir)
        ENV["JULIA_HISTORY"] = joinpath(pwd(), HISTORY_FILE)
    end
end

function add_localhistoryfile(targetdir = pwd(); append_gitignore = true)
    checkfiles = filter(x -> isfile(x), readdir(targetdir))
    if !(HISTORY_FILE in checkfiles)
        history_file = joinpath(targetdir, HISTORY_FILE)
        open(history_file, "w") do fp
            write(fp, "")
        end
    end
    if append_gitignore
        gifile = joinpath(targetdir, GITIGNORE)
        if GITIGNORE in checkfiles && !(HISTORYFILE in readlines(gifile))
            open(gifile, "a") do fp
                println(fp, "\n" * GITIGNORE)
            end
        end
    end
end

function rm_localhistoryfile(targetdir = pwd())
    checkfiles = filter(x -> isfile(x), readdir(targetdir))
    if !(HISTORY_FILE in checkfiles)
        rm(joinpath(targetdir, HISTORY_FILE))
    end
    if GITIGNORE in checkfiles
        gifile = joinpath(targetdir, GITIGNORE)
        none_historyfilegi = fileter(x -> x != GITIGNORE, readlines(gifile))
        open(gifile, "w") do fp
            for l in none_history_file_gi
                println(fp, l)
            end
        end
    end
end

end # module
