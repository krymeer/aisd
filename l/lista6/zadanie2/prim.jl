# Autor: Krzysztof Osada, 2017

include("primQueue.jl")
include("adjacency.jl")

function prim(V::Array{Int64,1}, E::Array{Edge,1})
  numberOfVertexes = length(V)
  
  cost = zeros(Float64, numberOfVertexes)
  prev = zeros(Int64, numberOfVertexes)
  for v in V
    cost[v] = Inf                                 # koszt dotarcia do wierzchołka
    prev[v] = -1                                  # wierzchołek, z którego osiągnęliśmy v
  end
  
  v0 = rand(V)                                    # losowy wierzchołek grafu
  cost[v0] = 0                                    # pierwszy wierzchołek znajdujący się w drzewie

  Q = makeQueue(V, cost)                          # kolejka priorytetowa (po kosztach podróży)
  sizeOfQ = length(Q)

  matrix = adjacencyMatrix(numberOfVertexes, E)   # macierz sąsiedztwa

  T = Int64[]                                     # kolejność wierzchołków w drzewie

  while sizeOfQ > 0
    u = extractMin(Q)                             # element o najmniejszym koszcie
    append!(T, u.id)
    sizeOfQ -= 1

    for v = 1 : numberOfVertexes
      if matrix[u.id,v] != 0.0
        k = isInQ(Q, v)
        if k != -1 && cost[v] > matrix[u.id,v]
          prev[v] = u.id                            # uaktualnienie poprzednika wierzchołka
          cost[v] = matrix[u.id,v]                  # oraz kosztu dotarcia do tego wierzchołka
          decreaseKey(Q, k, cost[v])                # zmniejszenie priorytetu (tzn. kosztu dotarcia)
        end
      end
    end
  end

  costSum = 0
  for i = 1 : numberOfVertexes                    # wyświetlanie rozwiązania
    if cost[T[i]] != 0.0 && prev[T[i]] != -1
      v1 = T[i]; v2 = prev[T[i]]; c = cost[v1]
      costSum += c
      if v1 > v2
        v1, v2 = swapVars(v1, v2)
      end
      println(v1, " ", v2, " ", c)
    end
  end
  println(costSum)                                # łączny koszt ekspoloracji MST
end