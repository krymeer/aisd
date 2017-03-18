function partialInsertionSort(A::Array{Int64}, a0::Int64, an::Int64)
  numA = 0; numC = 0
  for i = a0+1 : an
    key = A[i]
    # println("IS: klucz B[", i, "] = ", key)
    j = i-1
    while j >= a0 && A[j] > key
      # println("IS: porównanie key = ", key, " i B[", j, "] = ", B[j])
      numA += 1
      numC += 1
      A[j+1] = A[j]
      # println("IS: B[", j+1, "] = ", B[j+1])
      j -= 1
    end
    A[j+1] = key
    numA += 1
    # println("IS: B[", j+1, "] = ", key)    
  end
  return numA, numC
end