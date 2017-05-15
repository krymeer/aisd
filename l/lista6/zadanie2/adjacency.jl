# Autor: Krzysztof Osada, 2017

function adjacencyLists(n::Int64, E::Array{Edge,1})
  lists = Array{Array{Int64,1},1}(n)
  
  for k = 1 : n
    for j = 1 : length(E)
      toAdd = -1
      if E[j].v1 == k
        toAdd = E[j].v2
      elseif E[j].v2 == k
        toAdd = E[j].v1
      end

      if toAdd != -1
        if !isdefined(lists, k)
          lists[k] = [toAdd]
        else
          append!(lists[k], toAdd)
        end
      end
    end
  end
  return lists
end

function adjacencyMatrix(n::Int64, E::Array{Edge,1})
  M = zeros(Float64, n, n)
  for edge in E
    M[edge.v1,edge.v2] = edge.weight
    M[edge.v2,edge.v1] = M[edge.v1,edge.v2]
  end
  return M
end