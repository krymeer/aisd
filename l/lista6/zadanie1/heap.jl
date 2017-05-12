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
  numberOfComparisons = 0
  append!(H, value)
  i = length(H)
  p = parent(i)
  while i > 1 && H[p] > H[i]
    numberOfComparisons += 1
    swap(H, p, i)
    i = p
    p = parent(i)
  end
  return numberOfComparisons
end

function decreaseKey(H::Array{Int64,1}, i::Int64, newKey::Int64)
  if i > length(H)
    println("\nBłąd: w kolejce nie istnieje element o indeksie ", i)
  elseif H[i] < newKey
    println("\nBłąd: nowy klucz - ", newKey, " - nie jest mniejszy od bieżącego - ", H[i])
  else
    H[i] = newKey
    return bubbleUp(H, i)
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
    numberOfComparisons = heapify(H, 1)
    return smallest, numberOfComparisons
  end
end

function heapify(H::Array{Int64,1}, i::Int64)
  numberOfComparisons = 0

  l = left(i)
  r = right(i)
  smallest = i

  if l <= length(H) && H[l] < H[i]
    smallest = l
    numberOfComparisons += 1
  end

  if r <= length(H) && H[r] < H[smallest]
    smallest = r
    numberOfComparisons += 1
  end

  if smallest != i
    swap(H, i, smallest)
    numberOfComparisons += 1 + heapify(H, smallest)
  end

  return numberOfComparisons
end

function buildHeap(H::Array{Int64,1})
  for i = div(length(H), 2) : -1 : 1
    heapify(H, i)
  end
end