# Autor: Krzysztof Osada, 2017

type kruskalQueue
  v1::Int64
  v2::Int64
  weight::Float64
end

function swapEdges(Q::Array{kruskalQueue}, i::Int64, j::Int64)
  tmp = Q[i]
  Q[i] = Q[j]
  Q[j] = tmp
end

function makeEdgeQueue(E::Array{Edge,1})
  n = length(E)
  Q = kruskalQueue[]
  for i = 1 : n
    push!(Q, kruskalQueue(E[i].v1, E[i].v2, E[i].weight))
  end

  for i = div(n, 2) : -1 : 1
    kruskalHeapify(Q, i, n)
  end

  if n > 2 
    Q = heapSort(Q, n)
  else
    if Q[1].weight > Q[2].weight
      swapEdges(Q, 1, 2)
    end
  end
  return Q
end

function heapSort(Q::Array{kruskalQueue,1}, n::Int64)  
  nQ = kruskalQueue[]
  
  while n > 2
    swapEdges(Q, 1, n)
    push!(nQ, kruskalQueue(Q[n].v1, Q[n].v2, Q[n].weight))
    n -= 1
    kruskalHeapify(Q, 1, n)
  end

  return nQ
end

function kruskalHeapify(Q::Array{kruskalQueue,1}, i::Int64, n::Int64)
  l = left(i)
  r = right(i)
  smallest = i

  if l <= n && Q[l].weight < Q[i].weight
    smallest = l
  end

  if r <= n && Q[r].weight < Q[smallest].weight
    smallest = r
  end

  if smallest != i
    swapEdges(Q, i, smallest)
    kruskalHeapify(Q, smallest, n)
  end
end