# LocalREPLHistory

LocalREPLHistory is a tool to use a project local repl history for julia.

## Install 

First, yout must do init().

```
(v1.1) pkg> add https://github.com/p1scescom/LocalREPLHistory.jl
julia> using LocalREPLHistory

julia> LocalREPLHistory.init()
```

init() add a code to use ENV["JULIA_HISTORY"] to startup.jl.

# Usage

When you use local repl history project, you cd project directory.
Next,

```
$ julia -e "using LocalREPLHistory; LocalREPLHistory.add()"
```

or use repl.
But, if you use repl, local repl hisotry enables next run repl.

When you exec it, it makes .julia_history file .
And when the directory has .gitignore, it adds ".julia_history" to .gitignore .

# Delete

You don't need a local repl history, you exec this.

```
$ julia -e "using LocalREPLHistory; LocalREPLHistory.rm()"
```

It removes .julia_history and ".julia_history" from .gitignore .
