function merge(A::Array{Int64}, p::Int64, q::Int64, r::Int64)
  numA = 0; numC = 0; l = r-p+1; n = length(A)

  # tworzenie podtablicy A[a_p, ..., a_r]
  T = zeros(Int64, r-p+1)
  i = 1; j = p; m = 0
  while j <= r
    T[i] = A[j]
    if j == q
      m = i
    end
    i += 1
    j += 1
  end

  if n <= 25
    println("MS: scalenie dwóch tablic o długości ", q-p+1, " i ", r-q)
  end

  i = 1; j = m+1; k = p
  while i <= m && j <= l
    if n <= 25
      println("MS: porównanie T[", i, "] = ", T[i] ," i T[", j, "] = ", T[j])
    end

    if T[i] <= T[j]
      if n <= 25
        println("MS: A[", k, "] = T[", i, "] = ", T[i])
      end

      A[k] = T[i]
      i += 1
    else
      if n <= 25
        println("MS: A[", k, "] = T[", j, "] = ", T[j])
      end

      A[k] = T[j]
      j += 1
      numA += 1
    end
    k += 1
    numC += 1
  end

  while i <= m    # jeśli pozostały jakieś elementy w I części podtablicy
    if n <= 25
      println("MS: A[", k, "] = T[", i, "] = ", T[i])    
    end

    A[k] = T[i]
    i += 1
    k += 1
    numA += 1
  end

  while j <= l    # jeśli pozostały jakieś elementy w II części podtablicy
    if n <= 25
      println("MS: A[", k, "] = T[", j, "] = ", T[j])    
    end

    A[k] = T[j]
    j += 1
    k += 1
  end
  return numA, numC
end

function mergeSort(A::Array{Int64}, p::Int64, r::Int64)
  a = 0; c = 0
  if p < r
    q = div(p+r, 2)
    ba, bc = mergeSort(A, p, q)
    ca, cc = mergeSort(A, q+1, r)
    a, c = merge(A, p, q, r)
    a += ba+ca
    c += bc+cc
  end
  return a, c
end

function mergeSort(A::Array{Int64})
  return mergeSort(A, 1, length(A))
end