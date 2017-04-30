function LCSlength(X::Array{String,1}, Y::Array{String,1})
  m = length(X)
  n = length(Y)
  c = Array{Int64}(m+1, n+1)
  numberOfComparisons = 0

  for i = 1 : m
    for j = 1 : n
      numberOfComparisons += 1
      if X[i] == Y[j]
        c[i+1, j+1] = c[i, j] + 1
      else
        c[i+1, j+1] = max(c[i, j+1], c[i+1, j])
      end
    end
  end

  return c, c[m+1, n+1], numberOfComparisons
end

function getLCS(c::Array{Int64,2}, X::Array{String,1}, Y::Array{String,1})
  i = length(X); j = length(Y)
  result = ""

  while i > 0 && j > 0
    if X[i] == Y[j]
      result *= X[i]
      i -= 1
      j -= 1
    elseif c[i+1, j] >= c[i+1, j+1]
      j -= 1
    else
      i -= 1
    end
  end

  return reverse(result)
end