# Autor: Krzysztof Osada, 2017

function adjacencyLists(n::Int64, E::Array{Edge,1})
  lists = Array{Array{Int64,1},1}(n)
  
  for k = 1 : n
    for j = 1 : length(E)
      toAdd = -1
      if E[j].v1 == k
        toAdd = E[j].v2                         # Wybór wierzchołka połączonego z k
      elseif E[j].v2 == k
        toAdd = E[j].v1                         # jw.
      end

      if toAdd != -1
        if !isdefined(lists, k)
          lists[k] = [toAdd]
        else
          append!(lists[k], toAdd)              # Dodanie wierzchołka do listy sąsiedztwa
        end
      end
    end
  end
  return lists                                  # Lista list sąsiedztwa
end

function adjacencyMatrix(n::Int64, E::Array{Edge,1})
  M = zeros(Float64, n, n)
  for edge in E
    M[edge.v1,edge.v2] = edge.weight            # Jeśli wierzchołki v1 i v2 są połączone krawędzią, to odpowiadające
    M[edge.v2,edge.v1] = M[edge.v1,edge.v2]     # im pola sw macierzy sąsiedztwa mają wartość równą wadze krawędzi
  end
  return M
end

# Znalezienie wierzchołków połączonych krawędzią z k
function getAdjacent(k::Int64, M::Array{Float64,2})
  m = Int64(sqrt(length(M)))
  list = Int64[]

  for i = 1 : m
    if M[k,i] != 0.0
      append!(list, i)
    end
  end

  return list
end