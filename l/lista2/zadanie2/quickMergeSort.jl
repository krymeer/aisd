function quickMergeSort(A::Array{Int64}, p::Int64, r::Int64)
  a = 0
  c = 0
  if p < r
    if r-p <= 10
      a, c, q = partition(A, p, r)
      ba, bc = quickMergeSort(A, p, q-1)
      ca, cc = quickMergeSort(A, q+1, r)
    else
      q = div(p+r, 2)
      ba, bc = quickMergeSort(A, p, q)
      ca, cc = quickMergeSort(A, q+1, r)
      a, c = merge(A, p, q, r)
    end
    a += ba+ca
    c += bc+cc
  end
  return a, c
end

function quickMergeSort(A::Array{Int64})
  return quickMergeSort(A, 1, length(A))
end