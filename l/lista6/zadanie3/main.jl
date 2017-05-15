# Autor: Krzysztof Osada, 2017
# Implementacja algorytmu Dijkstry

include("edge.jl")
include("fileHandling.jl")
include("dijkstra.jl")

if typeof(STDIN) != IOStream
  helloMessage()
else
  if length(ARGS) != 1
    helloMessage()
  else
    source = try
      parse(Int64, ARGS[1])
    catch
      numberFormatException(ARGS[1])
    end
    V, E = getData(STDIN)
    n = length(V)
    if source < 1 || source > n
      chosenIndexOutOfBounds(source, n)
    end    
    dijkstra(V, E, source)
  end
end