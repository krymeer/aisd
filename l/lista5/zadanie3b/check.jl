include("editDistance.jl")
include("select.jl")

function findSimilar(word::String, dict::Array{String,1})
  found = Array{String,1}(3)
  n = length(dict)
  distance = Array{Int64,1}(n)
  for k = 1 : n
    distance[k] = editDistance(word, dict[k])
  end
  found[1] = dict[select(dict, distance, 1)]
  found[2] = dict[select(dict, distance, 2)]
  found[3] = dict[select(dict, distance, 3)]
  k = 3
  while found[2] == found[1]
    found[2] = dict[select(dict, distance, k)]
    k += 1
  end
  k = 4
  while found[3] == found[1] || found[3] == found[2]
    found[3] = dict[select(dict, distance, k)]
    k += 1
  end
  for i = 1 : 3
    if found[i] == word
      return true
    end
  end
  return found
end