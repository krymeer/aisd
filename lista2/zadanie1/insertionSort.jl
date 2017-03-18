function insertionSort(A::Array{Int64})
  size = length(A)
  numA = 0; numC = 0
  for i = 2 : size
    key = A[i]
    # println("IS: klucz A[", i, "] = ", key)
    j = i-1
    while j > 0 && A[j] > key
      # println("IS: porównanie key = ", key, " i A[", j, "] = ", A[j])
      numA += 1
      numC += 1
      A[j+1] = A[j]
      # println("IS: A[", j+1, "] = ", A[j+1])
      j -= 1
    end
    A[j+1] = key
    numA += 1
    # println("IS: A[", j+1, "] = ", key)    
  end
  return numA, numC
end