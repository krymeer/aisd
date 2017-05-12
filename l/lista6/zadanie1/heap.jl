function swap(H::Array{Int64,1}, i::Int64, j::Int64)
  tmp = H[i]
  H[i] = H[j]
  H[j] = tmp
end

function parent(i)
  return div(i, 2)
end

function left(i)
  return 2*i
end

function right(i)
  return 2*i+1
end

function Heap()
  return Array{Int64,1}(0)
end

function insert(H::Array{Int64,1}, value::Int64)
  append!(H, value)
  i = length(H)
  p = parent(i)
  while i > 1 && H[p] > H[i]
    swap(H, p, i)
    i = p
    p = parent(i)
  end
end

function decreaseKey(H::Array{Int64,1}, i::Int64, newKey::Int64)
  if i > length(H)
    println("\nBłąd: w kolejce nie istnieje element o indeksie ", i)
  elseif H[i] < newKey
    println("\nBłąd: nowy klucz - ", newKey, " - nie jest mniejszy od bieżącego - ", H[i])
  else
    H[i] = newKey
    bubbleUp(H, i)
  end
end

function extractMin(H::Array{Int64,1})
  len = length(H)
  if len == 0
    println("\nBłąd: kolejka jest pusta")
  else
    smallest = H[1]
    H[1] = H[len]
    deleteat!(H, len)
    heapify(H, 1)
    return smallest
  end
end

function heapify(H::Array{Int64,1}, i::Int64)
  l = left(i)
  r = right(i)
  smallest = i

  if l <= length(H) && H[l] < H[i]
    smallest = l
  end

  if r <= length(H) && H[r] < H[smallest]
    smallest = r
  end

  if smallest != i
    swap(H, i, smallest)
    heapify(H, smallest)
  end
end

function buildHeap(H::Array{Int64,1})
  for i = div(length(H), 2) : -1 : 1
    heapify(H, i)
  end
end