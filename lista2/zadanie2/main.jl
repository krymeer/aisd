include("mergeInsertionSort.jl")
include("quickInsertionSort.jl")
include("partialInsertionSort.jl")

function getMessage()
  println("Użycie:\n\n\tzadanie2.jl liczbaElementów algorytmSortowania typDanychWejściowych\n\n\tliczbaElementów:\n\t   mi ‒ połączenie sortowań: przez scalanie i przez wstawianie\n\t   qi ‒ połączenie sortowań: szybkiego i przez wstawianie\n\n\ttypDanychWejściowych:\n\t   desc ‒ ciąg posortowany malejąco\n\t   rand ‒ losowy ciąg")
end

type Data
  nA
  nC
end

function sortDesc(A::Array{Int64})
  n = length(A)
  for i = 1 : n
    for j = i+1 : n
      if A[i] < A[j]
        swap(A, i, j)
      end
    end
  end
end

function isSorted(A::Array{Int64})
  n = length(A)
  for i = 2 : n
    if (A[i] < A[i-1])
      println("\nBłąd: tablica nie jest posortowana\n")
      break
    end
  end
end

function plot(s::String, arr::Array{Data,1}, n::Int64, sequence::String)
  if s == "mi"
    algorithm = "mergeInsertionSort"
  else
    algorithm = "quickInsertionSort"
  end
  #time = Dates.format(now(), "yyyy-mm-dd_HH:MM:SS")
  i = 1; k = 100
  filename1 = string(algorithm, "_max_", n, "_arr_", sequence, ".txt")
  #filename1 = string(algorithm, "_max_", n, "_arr_", time, ".txt")
  open(filename1, "w") do f
    while k <= n
      na = arr[i].nA
      write(f, "$k $na\n")
      k += 100
      i += 1
    end
  end
  i = 1; k = 100
  filename2 = string(algorithm, "_max_", n, "_comp_", sequence, ".txt")
  #filename2 = string(algorithm, "_max_", n, "_comp_", time, ".txt")
  open(filename2, "w") do f
    while k <= n
      nc = arr[i].nC
      write(f, "$k $nc\n")
      k += 100
      i += 1
    end
  end
  #filename = string(algorithm, "_max_", n, "_", sequence, "_", time, ".png")
  filename = string(algorithm, "_max_", n, "_", sequence, ".png")
  run(`gnuplot -e "set term png; set output '$filename'; set xlabel 'SIZE OF DATA'; set ylabel 'NUMBER OF ARRANGEMENTS / COMPARISONS'; plot '$filename2' pt 20 title 'comparisons', '$filename1' pt 60 title 'arrangements'; set output"`)
end

function exec(n::Int64, algorithm::String, sequence::String)
  r = Data[]
  k = 100
  j = 1
  max = 10

  while k <= n
    avgA = 0
    avgC = 0
    for i = 1 : max
      A = rand(1:100000, k)
      if sequence == "desc"
        sortDesc(A)
      end
      if algorithm == "mi"
        a, c = mergeInsertionSort(A)
      else
        a, c = quickInsertionSort(A)
      end
      avgA += a
      avgC += c
      isSorted(A)
    end
    avgA = div(avgA, max)
    avgC = div(avgC, max)
    push!(r, Data(avgA, avgC))

    j += 1
    k += 100
  end
  plot(algorithm, r, n, sequence)
end

println()
if length(ARGS) == 3
  n = try
    parse(Int64, ARGS[1])
  catch
    getMessage()
  end
  if n != nothing
    if n < 100
      println("Błąd: minimalny rozmiar danych ‒ 100 elementów")
    elseif ARGS[2] == "mi" || ARGS[2] == "qi"
      if ARGS[3] == "desc" || ARGS[3] == "rand"
        exec(n, ARGS[2], ARGS[3])
      else
        getMessage()
      end
    else
      getMessage()
    end
  end
else
  getMessage()
end
println()