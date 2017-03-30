function insertionSort(A::Array{Int64,1})
  n = length(A)
  for i = 2 : n
    key = A[i]
    j = i-1
    while j > 0 && A[j] > key
      A[j+1] = A[j]
      j -= 1
    end
    A[j+1] = key
  end
end

function swap(A::Array{Int64,1}, a::Int64, b::Int64)
  tmp = A[a]
  A[a] = A[b]
  A[b] = tmp
end

function partition(A::Array{Int64,1}, p::Int64, r::Int64)
  x = A[r]
  k = p-1
  for j = p : r-1 
    if A[j] <= x
      k += 1
      swap(A, j, k)
    end
  end
  swap(A, k+1, r)
  return k+1
end

function merge(A::Array{Int64,1}, p::Int64, q::Int64, r::Int64)
  T = zeros(Int64, length(A))
  for k = p : r
    T[k] = A[k]
  end

  i = p
  j = q+1
  k = p

  while i <= q && j <= r
    if T[i] <= T[j]
      A[k] = T[i] 
      i += 1
    else
      A[k] = T[j]
      j += 1
    end
    k += 1
  end

  while i <= q
    A[k] = T[i] 
    i += 1
    k += 1
  end

  while j <= r
    A[k] = T[j] 
    j += 1
    k += 1
  end

end

function mergeSort(A::Array{Int64}, p::Int64, r::Int64)
  if r > p
    q = div(p+r, 2)
    mergeSort(A, p, q)
    mergeSort(A, q+1, r)
    merge(A, p, q, r)
  end
end

function mergeSort(A::Array{Int64})
  mergeSort(A, 1, length(A))
end

function quicksort(A::Array{Int64,1}, p::Int64, r::Int64)
  if r > p
    q = partition(A, p, r)
    quicksort(A, p, q-1)
    quicksort(A, q+1, r)
  end
end

function quicksort(A::Array{Int64,1})
  quicksort(A, 1, length(A))
end

A = [9, 8, 7, 2509, 666, 1313, 1500100900, 54, 3322, 809]; B = copy(A); C = copy(A)
println(A)
insertionSort(A)
println(A)

println(B)
quicksort(B)
println(B)

println(C)
mergeSort(C)
println(C)