# Autor: Krzysztof Osada, 2017

function parent(i)
  return i >> 1
end

function left(i)
  return i << 1
end

function right(i)
  return 1 + i << 1
end

function swapVars(a::Int64, b::Int64)
  tmp = a
  a = b
  b = tmp
  return a, b
end