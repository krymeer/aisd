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
    println("QS: pivot = A[", mid, "] = ", x, "\nQS: długość tablicy: ", b-a+1)
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

function quickSort(A::Array{Int64}, b0::Int64, bn::Int64)
  a = 0
  c = 0
  if b0 < bn
    a, c, q = partition(A, b0, bn)
    aa, ca = quickSort(A, b0, q-1)
    ab, cb = quickSort(A, q+1, bn)
    a += aa+ab
    c += ca+cb
  end
  return a, c
end

function quickSort(A::Array{Int64})
  return quickSort(A, 1, length(A))
end