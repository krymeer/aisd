include("editDistance.jl")
include("select.jl")
ccall(:jl_exit_on_sigint, Void, (Cint,), 0)

function findSimilar(word::String, dict::Array{String,1})
  try
    found = Array{String,1}(3)
    n = length(dict)
    distance = Array{Int64,1}(n)
    for k = 1 : n
      distance[k] = editDistance(word, dict[k])
    end
    found[1] = dict[select(dict, distance, 1)]
    found[2] = dict[2]
    found[3] = dict[3]
    for i = 1 : 3
      if found[i] == word
        return true
      end
    end
    return found
  catch exception
    if isa(exception, InterruptException)
      println()
      quit()
    end
  end
end