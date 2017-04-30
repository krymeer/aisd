function one(x::Char, y::Char)
  if x == y
    return 0
  else
    return 1
  end
end

function editDistance(X::String, Y::String)
  m = length(X)
  n = length(Y)
  E = Array{Int64,2}(m+1, n+1)
  ctr = 0
  
  for i = 0 : m
    E[i+1, 1] = i
  end
  
  for j = 0 : n
    E[1, j+1] = j
  end

  for i = 1 : m
    for j = 1 : n
      E[i+1, j+1] = min(E[i, j+1]+1, E[i+1, j]+1, E[i, j]+one(X[i], Y[j]))
      ctr += 1
    end
  end

  return E[m+1, n+1], ctr
end