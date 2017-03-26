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