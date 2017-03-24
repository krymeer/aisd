function insertionSort(A::Array{Int64})
  size = length(A)
  numA = 0; numC = 0
  for i = 2 : size
    key = A[i]
    j = i-1

    if n <= 25
      println("IS: klucz A[", i, "] = ", key)
    end

    while j > 0 && A[j] > key
      numA += 1
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
  return numA, numC
end