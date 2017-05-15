# Autor: Krzysztof Osada, 2017

include("edge.jl")
include("fileHandling.jl")
include("appendix.jl")
include("prim.jl")
include("kruskal.jl")

if typeof(STDIN) != IOStream
  helloMessage()
else
  if length(ARGS) != 1
    helloMessage()
  elseif ARGS[1] != "kruskal" && ARGS[1] != "prim"
    helloMessage()
  else
    V, E = getData(STDIN)
    if (ARGS[1] == "prim")
      prim(V, E)
    else
      kruskal(V, E)
    end
  end
end