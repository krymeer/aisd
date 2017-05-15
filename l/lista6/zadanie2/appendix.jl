# Autor: Krzysztof Osada, 2017

function swapVars(a::Int64, b::Int64)
  tmp = a
  a = b
  b = tmp
  return a, b
end