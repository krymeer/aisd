# Autor: Krzysztof Osada, 2017

type Edge
  v1::Int64
  v2::Int64
  weight::Float64
end

if (length(ARGS) == 1)
  filename = ARGS[1]
  f = open(filename)
  lines = readlines(f)
  close(f)

  numberOfVertexes = parse(Int64, lines[1])
  numberOfEdges = parse(Int64, lines[2])
  deleteat!(lines, 1)
  deleteat!(lines, 1)

  E = Edge[]

  for line in lines
    param = split(line)
    push!(E, Edge(parse(Int64, param[1]), parse(Int64, param[2]), parse(Float64, param[3])))
  end

  filename = string(filename[1:length(filename)-4], "_mod.txt")
  open(filename, "w") do f
    write(f, "$numberOfVertexes\n")
    write(f, "$numberOfEdges\n")
    for i = 1 : length(E)
      V1 = E[i].v1+1
      V2 = E[i].v2+1
      WEIGHT = E[i].weight
      write(f, "$V1 $V2 $WEIGHT")
      if i < length(E)
        write(f, "\n")
      end
    end
  end
  println("\nPlik poprawiony i zapisany pod nazwą: ", filename, "\n")
end