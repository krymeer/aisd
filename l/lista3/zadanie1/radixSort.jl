include("appendix.jl")

function countingSort(A::Array{String,1}, n::Int64, d::Int64, r::Int64)
  B = copy(A)
  numA = 0  # liczba przestawień

  number = 0
  k = biggestNumber(r)
  C = zeros(Int64, k+1)

  for j = 1 : n
    if d-r+1 < 1
      number = toInt(A[j][1:d])     # ilość bitów [liczby w systemie binarnym], z jakich będzie się składać jedna "cyfra"
    else
      number = toInt(A[j][d-r+1:d])
    end
    C[number+1] += 1
  end

  for i = 1 : k
    C[i+1] += C[i]
  end

  for j = n : -1 : 1
    if d-r+1 < 1
      number = toInt(A[j][1:d])
    else
      number = toInt(A[j][d-r+1:d])
    end
    B[C[number+1]] = A[j]

    if n <= 25
      println("CS: B[", C[number+1], "] = A[", j, "] = ", A[j], " = ", toInt(A[j]))
    end
    if B[j] != A[j]
      numA += 1
    end
    
    C[number+1] -= 1
  end

  return numA, B
end

function radixSort(A::Array{Int64,1})
  n = length(A)
  S = Array{String,1}(n)
  for i = 1 : n
    S[i] = toBinaryString(A[i])
  end
  b = getMaximumLengthOfBinaryString(S)   # maksymalna długość liczby (w bitach) 

  r = 0
  if b <= floor(log(2, n))
    r = Int64(b)                          # ilość bitów jednej cyfry
  else
    r = Int64(floor(log(2, n)))
  end

  addZeroPadding(S, b)                    # wypełnienie zerami liczb o zapisie krótszym niż b bitów

  totalA = 0
  for i = b : -r : 1                      # każda cyfra liczby b-bitowej ma r bitów

    if n <= 25
      println("RS: sortowanie liczb po ", i, ". cyfrze od końca")
    end

    a, S = countingSort(S, n, i, r)
    totalA += a
  end

  return totalA, toIntArray(S)
end