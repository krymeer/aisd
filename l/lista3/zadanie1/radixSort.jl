include("appendix.jl")

function countingSort(A::Array{String,1}, n::Int64, d::Int64, length::Int64)
  C = Array{Int64,1}(2)
  B = copy(A)
  numA = 0  # liczba przestawień

  C[1] = 0; C[2] = 0

  for j = 1 : n
    digit = parse(Int64, A[j][d])
    C[digit+1] += 1
  end

  if n <= 25
    println("CS: liczb mających bit '0' na ", d, ". cyfrze od końca: ", C[1], ", '1' - ", C[2])
  end

  C[2] += C[1]

  for j = n : -1 : 1
    digit = parse(Int64, A[j][d])
    B[C[digit+1]] = A[j]

    if n <= 25
      println("CS: B[", C[digit+1], "] = A[", j, "] = ", A[j], " = ", toInt(A[j]))
    end
    if B[j] != A[j]
      numA += 1
    end
    
    C[digit+1] -= 1
  end
  return numA, B
end

function radixSort(A::Array{Int64,1})
  n = length(A)
  S = Array{String,1}(n)
  for i = 1 : n
    S[i] = toBinaryString(A[i])
  end
  d = getMaximumLengthOfBinaryString(S)
  addZeroPadding(S, d)

  totalA = 0
  for i = d : -1 : 1

    if n <= 25
      println("RS: sortowanie liczb po ", i, ". cyfrze od końca")
    end

    a, S = countingSort(S, n, i, d)
    totalA += a
  end

  return totalA, toIntArray(S)
end