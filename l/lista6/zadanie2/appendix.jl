# Autor: Krzysztof Osada, 2017

# Indeks rodzica elementu kolejki priorytetowej
function parent(i)
  return i >> 1
end

# Indeks lewego syna elementu kolejki priorytetowej
function left(i)
  return i << 1
end

# Indeks prawego syna elementu kolejki priorytetowej
function right(i)
  return 1 + i << 1
end

# Zamiana wartości dwóch zmiennych ze sobą
function swapVars(a::Int64, b::Int64)
  tmp = a
  a = b
  b = tmp
  return a, b
end