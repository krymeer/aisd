function powOfTwo(n::Int64)
  return (n != 0) && ((n & (n-1)) == 0)
end

function printHeap(H::Array{Int64,1})
  len = length(H)
  for i = 1 : len
    print(H[i], " ")
    if powOfTwo(i+1)
      print("\n")
    end
  end
  println()
end

function bubbleUp(H::Array{Int64,1}, index::Int64)
  if index > 1
    p = parent(index)
    if H[p] > H[index] && index > 1
      swap(H, p, index)
      bubbleUp(H, p)
    end
  end
end