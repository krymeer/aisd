function randPart(A::Array{Int64,1}, p::Int64, q::Int64)
  pivot = rand(p:q)
  return partition(A, p, q, pivot)
end

function randomizedSelect(A::Array{Int64,1}, p::Int64, q::Int64, i::Int64)
  if p == q
    return 0, A[p]
  end
  c, pivotIndex = randPart(A, p, q)     # indeks pivota w całej tablicy
  k = pivotIndex-p + 1                  # indeks pivota w podtablicy [a_p, ..., a_q]
  if i == k
    if length(A) <= 25
      println("RS: znaleziono ", pivotIndex, ". statystykę pozycyjną")
    end
    return c, A[pivotIndex]
  elseif i < k
    if length(A) <= 25
      println("RS: szukana statystyka pozycyjna znajduje się w podtablicy [a_", p, ", ..., a_", pivotIndex-1, "]")
    end
    c0, v = randomizedSelect(A, p, pivotIndex-1, i)
  else
    if length(A) <= 25
      println("RS: szukana statystyka pozycyjna znajduje się w podtablicy [a_", pivotIndex+1, ", ..., a_", q, "]")
    end
    c0, v = randomizedSelect(A, pivotIndex+1, q, i-k)
  end
  return c+c0, v
end

function randomizedSelect(A::Array{Int64,1}, k::Int64)
  return randomizedSelect(A, 1, length(A), k)
end