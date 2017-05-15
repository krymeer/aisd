function adjacencyMatrix(n::Int64, E::Array{Edge,1})
  M = zeros(Float64, n, n)
  for edge in E
    M[edge.v1,edge.v2] = edge.weight            # Jeśli wierzchołki v1 i v2 są połączone krawędzią, to odpowiadające
    M[edge.v2,edge.v1] = M[edge.v1,edge.v2]     # im pola sw macierzy sąsiedztwa mają wartość równą wadze krawędzi
  end
  return M
end