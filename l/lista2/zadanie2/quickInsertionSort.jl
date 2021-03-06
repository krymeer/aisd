function swap(A::Array{Int64}, i::Int64, j::Int64)
  tmp = A[i]
  A[i] = A[j]
  A[j] = tmp
end

function partition(A::Array{Int64}, a::Int64, b::Int64)
  numA = 0; numC = 0; n = length(A)
  mid = div((a+b), 2)
  x = A[mid]              # pivot ‒ element środkowy tablicy
  swap(A, mid, b)
  
  if n <= 25
    println("QIS: pivot = A[", mid, "] = ", x, "\nQIS: długość tablicy: ", b-a+1)
  end

  i = a
  for j = a : b-1  
    
    if n <= 25
      println("QIS: porównanie A[", j, "] = ", A[j], " i A[", b, "] = ", x)
    end

    numC += 1
    if A[j] < x
      if i != j
        swap(A, i, j)
  
        if n <= 25
          println("QIS: A[", i, "] <-> A[", j, "]")
        end
  
        numA += 1
      end
      i += 1
    end
  end
  
  if n <= 25
    println("QIS: A[", i, "] <-> A[", b, "]")
  end
  
  swap(A, i, b)
  numA += 1
  return numA, numC, i
end

function quickInsertionSort(A::Array{Int64}, b0::Int64, bn::Int64)
  totA = 0; totC= 0;
  if b0 < bn
    if bn-b0 <= 5
      totA, totC = partialInsertionSort(A, b0, bn)
    else
      totA, totC, q = partition(A, b0, bn)
      aa, ca, = quickInsertionSort(A, b0, q-1)
      ab, cb = quickInsertionSort(A, q+1, bn)
      totA += aa+ab
      totC += ca+cb
    end
  end
  return totA, totC
end

function quickInsertionSort(A::Array{Int64})
  return quickInsertionSort(A, 1, length(A))
end