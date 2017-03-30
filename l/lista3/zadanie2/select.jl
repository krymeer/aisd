function medianOfMedians(A::Array{Int64,1}, l::Int64, r::Int64)
  if r-l + 1 <= 10
    c = partialInsertionSort(A, l, r)
    return c, div(l+r, 2)
  end

  c = 0
  numberOfMedians = 0
  for i = l : 5 : r
    subR = i+4
    if subR > r
      subR = r
    end
    c = partialInsertionSort(A, i, subR)
    m = i+2
    if i+4 > r
      m = div(i+r, 2)             # mediana 5-elementowej podtablicy
    end
    swap(A, m, l + div(i-l, 5))   # przeniesienie mediany na początek tablicy
    numberOfMedians += 1
  end
  cs, s = select(A, l, l+numberOfMedians-1, div(numberOfMedians, 2))   # mediana median
  return c+cs, s 

end

function select(A::Array{Int64,1}, l::Int64, r::Int64, kIndex::Int64)
  if l >= r
    return 0, l
  end
  c1, medianIndex = medianOfMedians(A, l, r)        # mediana median
  c2, pivotIndex = partition(A, l, r, medianIndex)  # indeks mediany median

  if length(A) <= 25
    println("Select: mediana median to A[", medianIndex, "] = ", A[medianIndex])
  end

  if pivotIndex == kIndex

    if length(A) <= 25
      println("Select: znaleziono ", kIndex, ". statystykę pozycyjną: ", A[kIndex])
    end

    return c1+c2, kIndex
  elseif kIndex < pivotIndex

    if length(A) <= 25
      println("Select: ", kIndex, ". statystyka pozycyjna znajduje się w podtablicy [a_", l, ", ..., a_", pivotIndex-1, "]")
    end

    c3, s = select(A, l, pivotIndex-1, kIndex)
  else

    if length(A) <= 25
      println("Select: ", kIndex, ". statystyka pozycyjna znajduje się w podtablicy [a_", pivotIndex+1, ", ..., a_", r, "]")
    end

    c3, s = select(A, pivotIndex+1, r, kIndex)
  end
  return c1+c2+c3, s
end

function select(A::Array{Int64,1}, k::Int64)
  c, kIndex = select(A, 1, length(A), k)
  return c, A[kIndex]
end