module LocalREPLHistory

HISTORY_FILE = ".julia_history"
GITIGNORE = ".gitignore"

function init()
    open(joinpath(homedir(), ".julia/config/startup.jl"), "a") do fp
        print(fp, """
using LocalREPLHistory; LocalREPLHistory.use_localhistoryfile()
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
    if append_gitignore && GITIGNORE in checkfiles
        gifile = joinpath(targetdir, GITIGNORE)
        gilines = readlines(gifile,keep=true)
        if !(HISTORY_FILE in gilines)
            open(gifile, "a") do fp
                if length(gilines) != 0 && gilines[end][end] != '\n'
                    print(fp, "\n")
                end
                print(fp, HISTORY_FILE * "\n")
            end
        end
    end
    use_localhistoryfile(targetdir)
end

add = add_localhistoryfile

function rm_localhistoryfile(targetdir = pwd())
    checkfiles = filter(x -> isfile(x), readdir(targetdir))
    if HISTORY_FILE in checkfiles
        Base.Filesystem.rm(joinpath(targetdir, HISTORY_FILE))
    end
    if GITIGNORE in checkfiles
        gifile = joinpath(targetdir, GITIGNORE)
        none_historyfilegi = filter(x -> x != HISTORY_FILE, readlines(gifile))
        if length(none_historyfilegi) != 0
            open(gifile, "w") do fp
                for l in none_historyfilegi
                    println(fp, l)
                end
            end
        end
    end
end

rm = rm_localhistoryfile

end # module
