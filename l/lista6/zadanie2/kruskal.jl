# Autor: Krzysztof Osada, 2017

include("kruskalQueue.jl")

function kruskal(V::Array{Int64,1}, E::Array{Edge,1})
  numberOfVertexes = length(V)

  pparent = zeros(Int64, numberOfVertexes)
  rrank = copy(pparent)

  for u in V
    pparent[u] = u                                          # Do wierzchołka u można dotrzeć z jego rodzica
  end

  T = Edge[]                                                # Rozwiązanie problemu - MST
  Q = makeEdgeQueue(E)                                      # Sortowanie krawędzi według wag w porządku niemalejącym

  for edge in Q
    if ffind(edge.v1, pparent) != ffind(edge.v2, pparent)
      push!(T, Edge(edge.v1, edge.v2, edge.weight))
      uunion(edge.v1, edge.v2, pparent, rrank)
    end
  end

  cost = 0
  for edge in T
    println(edge.v1, " ", edge.v2, " ", edge.weight)        # Wyświetlanie użytych krawędzi
    cost += edge.weight
  end
  println(cost)                                             # Wyświetlanie kosztu eksploracji drzewa
end

# Pobranie wierzchołka, od którego zaczyna się dana komponenta (ścieżka)
function ffind(v::Int64, pparent::Array{Int64,1})
  while v != pparent[v]
    v = pparent[v]
  end
  return v
end

# Połączenie dwóch zbiorów krawędzi
function uunion(x::Int64, y::Int64, pparent::Array{Int64,1}, rrank::Array{Int64,1})
  idx = ffind(x, pparent)
  idy = ffind(y, pparent)

  if idx != idy
    if rrank[idx] > rrank[idy]      # Pierwsza komponenta dominuje nad drugą (ma wyższą rangę)
      pparent[idy] = idx            # Druga komponenta staje się poddrzewem pierwszej
    else
      pparent[idx] = idy            # Pierwsza komponenta staje się poddrzewem drugiej
      if rrank[idx] == rrank[idy]   # Żadna z komponent nie dominuje
        rrank[idy] += 1             # Druga komponenta zaczyna dominować nad pierwszą
        println(rrank[idy])
      end
    end
  end
end