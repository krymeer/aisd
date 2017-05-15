# Autor: Krzysztof Osada, 2017

type Edge
  v1::Int64
  v2::Int64
  weight::Float64
end

type Vertex
  id::Int64
  cost::Float64
  prev::Int64
end

function isInGraph(v::Int64, V::Array{Vertex,1})
  for vertex in V
    if vertex.id == v
      return true
    end
  end
  return false
end
