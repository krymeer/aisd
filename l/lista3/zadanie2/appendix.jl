function printSubarray(A::Array{Int64,1}, st::Int64)
  n = length(A)
  for j = st : st+4
    if j > n
      break
    end
    print(A[j], " ")
  end
  println()
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

function permute(A::Array{Int64,1})
  n = length(A)
  for i = n-1 : -1 : 1
    j = rand(1:i+1)
    swap(A, i, j)
  end
end

function swap(A::Array{Int64}, i::Int64, j::Int64)
  tmp = A[i]
  A[i] = A[j]
  A[j] = tmp
end

function partition(A::Array{Int64}, a::Int64, b::Int64, xIndex::Int64)
  numC = 0; n = length(A)
  x = A[xIndex]
  swap(A, xIndex, b)

  if n <= 25
    println("Partition: pivot = A[", xIndex, "] = ", x, "\nPartition: długość tablicy: ", b-a+1)
  end

  i = a
  for j = a : b-1
    numC += 1

    if n <= 25
      println("Partition: porównanie A[", j, "] = ", A[j], " i A[", b, "] = ", x)
    end

    if A[j] < x
      if i != j
        swap(A, i, j)

        if n <= 25
          println("Partition: A[", i, "] <-> A[", j, "]")
        end
      end
      i += 1
    end
  end

  if n <= 25
    println("Partition: A[", i, "] <-> A[", b, "]")
  end

  swap(A, i, b)
  return numC, i
end

function quickSort(A::Array{Int64}, b0::Int64, bn::Int64)
  c = 0
  if b0 < bn
    c, q = partition(A, b0, bn, div((b0+bn), 2))
    ca = quickSort(A, b0, q-1)
    cb = quickSort(A, q+1, bn)
    c += ca+cb
  end
  return c
end

function quickSort(A::Array{Int64})
  return quickSort(A, 1, length(A))
end

function partialInsertionSort(A::Array{Int64}, a0::Int64, an::Int64)
  n = length(A)
  numC = 0
  for i = a0+1 : an
    key = A[i]

    if n <= 25
      println("IS: klucz A[", i, "] = ", key)
    end
    
    j = i-1
    while j >= a0 && A[j] > key
      numC += 1
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
  return numC
end
