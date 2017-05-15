# Autor: Krzysztof Osada, 2017

include("queue.jl")
include("matrix.jl")

function dijkstra(V::Array{Int64,1}, E::Array{Edge,1}, source::Int64)
  numberOfVertexes = length(V)
  
  dist = zeros(Float64, numberOfVertexes)
  prev = zeros(Int64, numberOfVertexes)
  for u = 1 : numberOfVertexes
    dist[u] = Inf                                       # odległość każdego z wierzchołków od źródła
    prev[u] = -1                                        # poprzednik wierzchołka na ścieżce wychodzącej od źródła
  end
  dist[source] = 0                                      # wyróżniony wierzchołek (source - źródło)

  Q = makeQueue(V, dist)                                # kolejka priorytetowa (po odległościach od źródła)
  sizeOfQ = length(Q)

  w = adjacencyMatrix(numberOfVertexes, E)              # macierz sąsiedztwa
  T = Int64[]

  while sizeOfQ > 0
    u = extractMin(Q)
    append!(T, u.id)                                    # wierzchołek leżący najbliżej źródła
    sizeOfQ -= 1

    for v = 1 : numberOfVertexes
      if w[u.id,v] != 0.0
        k = isInQ(Q, v)
        if k != -1 && dist[v] > dist[u.id] + w[u.id,v]  # relaksacja: dystans to suma wag krawędzi, jakie trzeba wykorzystać, aby ze źródła przejść do celu
          prev[v] = u.id
          dist[v] = dist[u.id] + w[u.id,v]
          decreaseKey(Q, k, dist[v])                    # zapisanie aktualnego dystansu od źródła
        end
      end
    end
  end

  for v in T
    if v != source
      println(source, " ", v, " ", dist[v])             # początek i koniec danej ścieżki
      p = prev[v]
      while p != -1
        println(" ", p, " ", v, " ", w[v,p])            # krawędź (początek, koniec, waga) wykorzystana do konstrukcji ścieżki
        v = p
        p = prev[v]
      end
      println()

    end
  end

  cost = 0
  for d in dist
    cost += d
  end
  println("Łączny koszt pokonania ścieżek: ", cost)
end