function swap(A::Array{Int64}, i::Int64, j::Int64)
  tmp = A[i]
  A[i] = A[j]
  A[j] = tmp
end

function sortDesc(A::Array{Int64})
  n = length(A)
  for i = 1 : n
    for j = i+1 : n
      if A[i] < A[j]
        swap(A, i, j)
      end
    end
  end
end

function isSorted(A::Array{Int64})
  n = length(A)
  for i = 2 : n
    if (A[i] < A[i-1])
      println("\nBłąd: tablica nie jest posortowana\n")
      break
    end
  end
end

function partialInsertionSort(A::Array{Int64}, a0::Int64, an::Int64)
  n = length(A)
  numA = 0; numC = 0
  for i = a0+1 : an
    key = A[i]

    if n <= 25
      println("IS: klucz A[", i, "] = ", key)
    end
    
    j = i-1
    while j >= a0 && A[j] > key
      numA += 1; numC += 1
      A[j+1] = A[j]

      if n <= 25
        println("IS: porównanie key = ", key, " i A[", j, "] = ", A[j])
        println("IS: A[", j+1, "] = ", A[j+1])
      end

      j -= 1
    end
    A[j+1] = key
    if n <= 25
      println("IS: A[", j+1, "] = ", key)    
    end
  end
  return numA, numC
end

function partition(A::Array{Int64}, a::Int64, b::Int64, pivotIndex::Int64)
  numA = 0; numC = 0; n = length(A)
  x = A[pivotIndex]
  swap(A, pivotIndex, b)

  if n <= 25
    println("QS: pivot = A[", pivotIndex, "] = ", x, "\nQS: długość tablicy: ", b-a+1)
  end

  i = a
  for j = a : b-1
    numC += 1

    if n <= 25
      println("QS: porównanie A[", j, "] = ", A[j], " i A[", b, "] = ", x)
    end

    if A[j] < x
      if i != j
        swap(A, i, j)
        numA += 1

        if n <= 25
          println("QS: A[", i, "] <-> A[", j, "]")
        end
      end
      i += 1
    end
  end

  if n <= 25
    println("QS: A[", i, "] <-> A[", b, "]")
  end

  swap(A, i, b)
  numA += 1
  return numA, numC, i
end

function select(A::Array{Int64,1}, l::Int64, r::Int64, kIndex::Int64)
  if l >= r
    return 0, 0, l
  end
  a1, c1, medianIndex = medianOfMedians(A, l, r)        # mediana median
  a2, c2, pivotIndex = partition(A, l, r, medianIndex)  # indeks mediany median

  if length(A) <= 25
    println("Select: mediana median to A[", medianIndex, "] = ", A[medianIndex])
  end

  if pivotIndex == kIndex

    if length(A) <= 25
      println("Select: znaleziono ", kIndex, ". statystykę pozycyjną: ", A[kIndex])
    end

    return a1+a2, c1+c2, kIndex
  elseif kIndex < pivotIndex

    if length(A) <= 25
      println("Select: ", kIndex, ". statystyka pozycyjna znajduje się w podtablicy [a_", l, ", ..., a_", pivotIndex-1, "]")
    end

    a3, c3, s = select(A, l, pivotIndex-1, kIndex)
  else

    if length(A) <= 25
      println("Select: ", kIndex, ". statystyka pozycyjna znajduje się w podtablicy [a_", pivotIndex+1, ", ..., a_", r, "]")
    end

    a3, c3, s = select(A, pivotIndex+1, r, kIndex)
  end
  return a1+a2+a3, c1+c2+c3, s
end

function medianOfMedians(A::Array{Int64,1}, l::Int64, r::Int64)
  if r-l + 1 <= 10
    a, c = partialInsertionSort(A, l, r)
    return a, c, div(l+r, 2)
  end

  numA = 0; numC = 0
  numberOfMedians = 0
  for i = l : 5 : r
    subR = i+4
    if subR > r
      subR = r
    end
    numA, numC = partialInsertionSort(A, i, subR)
    m = i+2
    if i+4 > r
      m = div(i+r, 2)             # mediana 5-elementowej podtablicy
    end
    numA += 1 
    swap(A, m, l + div(i-l, 5))   # przeniesienie mediany na początek tablicy
    numberOfMedians += 1
  end
  a, c, s = select(A, l, l+numberOfMedians-1, div(numberOfMedians, 2))   # mediana median
  return numA+a, numC+c, s 

end