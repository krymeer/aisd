# Autor: Krzysztof Osada, 2017

# Komunikat wyświetlany w przypadku podania nieprawidłowych argumentów wejściowych
function helloMessage()
  @printf(STDERR, "\nużycie:\n\t./main <In >Out Alg\ngdzie:\n\tIn: ścieżka do pliku wejściowego\n\tOut: ścieżka do pliku wyjściowego\n\tAlg: wybrany algorytm (Prima bądź Kruskala)\n\n")
end

# Komunikat wyświetlany w przypadku przekroczenia zadeklarowanej liczby wierzchołków
function vertexIndexOutOfBounds(k::Int64, n::Int64)
  @printf(STDERR, "\nBłąd: liczba wierzchołków - co najmniej %d - jest większa od zadeklarowanej (%d)\n\n", k, n)
  quit()
end

# Komunikat wyświetlany w przypadku przekroczenia zadeklarowanej liczby krawędzi
function edgeIndexOutOfBounds(k::Int64, n::Int64)
  @printf(STDERR, "\nBłąd: liczba krawędzi - co najmniej %d - jest większa od zadeklarowanej (%d)\n\n", k, n)
  quit()
end

# Pobranie danych z pliku wejściowego
function getData(stdin::IOStream)
  numberOfVertexes = parse(Int64, readline(stdin))
  V = collect(1:numberOfVertexes)

  numberOfEdges = parse(Int64, readline(stdin))
  E = Edge[]
  
  k = 1; v = 1
  for line in eachline(stdin)
    param = split(line)
    
    v1 = parse(Int64, param[1])
    v2 = parse(Int64, param[2])

    if v1 > numberOfVertexes
      vertexIndexOutOfBounds(v1, numberOfVertexes)
    end

    if v2 > numberOfVertexes
      vertexIndexOutOfBounds(v2, numberOfVertexes)
    end

    if k > numberOfEdges
      edgeIndexOutOfBounds(k, numberOfEdges)
    end

    push!(E, Edge(v1, v2, parse(Float64, param[3])))
    k += 1
  end

  return V, E
end