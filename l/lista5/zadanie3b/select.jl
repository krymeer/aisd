function swap(A::Array, a::Int64, b::Int64)
  tmp = A[a]
  A[a] = A[b]
  A[b] = tmp
end

function partition(D::Array{String,1}, A::Array{Int64,1}, a::Int64, b::Int64, pivotIndex::Int64)
  x = A[pivotIndex]
  swap(A, pivotIndex, b)
  swap(D, pivotIndex, b)

  i = a
  for j = a : b-1
    if A[j] < x
      if i != j
        swap(A, i, j)
        swap(D, i, j)
      end
      i += 1
    end
  end

  swap(A, i, b)
  swap(D, i, b)
  return i
end

function partialInsertionSort(D::Array{String,1}, A::Array{Int64,1}, a0::Int64, an::Int64)
  for i = a0+1 : an
    key = A[i]
    str = D[i]
    j = i-1
    while j >= a0 && A[j] > key
      A[j+1] = A[j]
      D[j+1] = D[j]
      j -= 1
    end
    A[j+1] = key
    D[j+1] = str
  end
end

function medianOfMedians(D::Array{String,1}, A::Array{Int64,1}, l::Int64, r::Int64)
  if r-l + 1 <= 10
    partialInsertionSort(D, A, l, r)
    return div(l+r, 2)
  end

  numberOfMedians = 0
  for i = l : 5 : r
    subR = i+4
    if subR > r
      subR = r
    end
    partialInsertionSort(D, A, i, subR)
    m = i+2
    if i+4 > r
      m = div(i+r, 2)
    end
    swap(D, m, l + div(i-l, 5))
    swap(A, m, l + div(i-l, 5))
    numberOfMedians += 1
  end
  return select(D, A, l, l+numberOfMedians-1, div(numberOfMedians, 2)) 
end

function select(D::Array{String,1}, A::Array{Int64,1}, l::Int64, r::Int64, kIndex::Int64)
  if l >= r
    return l
  end
  medianIndex = medianOfMedians(D, A, l, r)
  pivotIndex = partition(D, A, l, r, medianIndex)

  if pivotIndex == kIndex
    return kIndex
  elseif kIndex < pivotIndex    
    return select(D, A, l, pivotIndex-1, kIndex)
  else
    return select(D, A, pivotIndex+1, r, kIndex)
  end
end

function select(D::Array{String,1}, A::Array{Int64,1}, k::Int64)
  return select(D, A, 1, length(A), k)
end