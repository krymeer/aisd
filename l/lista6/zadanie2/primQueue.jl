# Autor: Krzysztof Osada, 2017

type primQueue
  id::Int64
  cost::Float64
end

function swapVertexes(Q::Array{primQueue,1}, i::Int64, j::Int64)
  tmp = Q[i]
  Q[i] = Q[j]
  Q[j] = tmp
end

function bubbleUp(Q::Array{primQueue,1}, index::Int64)
  if index > 1
    p = parent(index)
    if Q[p].cost > Q[index].cost && index > 1
      swapVertexes(Q, p, index)
      bubbleUp(Q, p)
    end
  end
end

function makeQueue(V::Array{Int64,1}, cost::Array{Float64,1})
  n = length(V)
  Q = primQueue[]
  for i = 1 : n
    push!(Q, primQueue(V[i], cost[i]))
  end

  for i = div(n, 2) : -1 : 1
    heapify(Q, i)
  end
  return Q
end

function heapify(Q::Array{primQueue,1}, i::Int64)
  l = left(i)
  r = right(i)
  smallest = i
  n = length(Q)

  if l <= n && Q[l].cost < Q[i].cost
    smallest = l
  end

  if r <= n && Q[r].cost < Q[smallest].cost
    smallest = r
  end

  if smallest != i
    swapVertexes(Q, i, smallest)
    heapify(Q, smallest)
  end
end

function extractMin(Q::Array{primQueue,1})
  len = length(Q)
  if len == 0
    println("\nBłąd: kolejka jest pusta")
  else
    smallest = Q[1]
    Q[1] = Q[len]
    deleteat!(Q, len)
    heapify(Q, 1)
    return smallest
  end
end

function isInQ(Q::Array{primQueue,1}, u::Int64)
  for i = 1 : length(Q)
    if Q[i].id == u
      return i
    end
  end
  return -1
end

function decreaseKey(Q::Array{primQueue,1}, i::Int64, newCost::Float64)
  if i > length(Q)
    println("\nBłąd: w kolejce nie istnieje element o indeksie ", i)
  elseif Q[i].cost < newCost
    println("\nBłąd: nowy klucz - ", newCost, " - nie jest mniejszy od bieżącego - ", Q[i].cost)
  else
    Q[i].cost = newCost
    return bubbleUp(Q, i)
  end
end