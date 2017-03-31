function quickSortMod(A::Array{Int64}, b0::Int64, bn::Int64)
  a = 0
  c = 0
  if b0 < bn
    am, cm, m = medianOfMedians(A, b0, bn)
    a, c, q = partition(A, b0, bn, m)
    aa, ca = quickSortMod(A, b0, q-1)
    ab, cb = quickSortMod(A, q+1, bn)
    a += aa+ab
    c += ca+cb
  end
  return a, c
end

function quickSortMod(A::Array{Int64,1})
  return quickSortMod(A, 1, length(A))
end