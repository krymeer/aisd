include("radixSort.jl")

function getMessage()
  println("Użycie:\n\n\tzadanie2.jl liczbaElementów algorytmSortowania typDanychWejściowych\n\n\talgorytmSortowania:\n\t   x ‒ radix sort\n\t   r ‒ randomized-select\n\t   s ‒ select\n\n\ttypDanychWejściowych:\n\t   desc ‒ ciąg posortowany malejąco\n\t   rand ‒ losowy ciąg")
end

type Data
  nA
  nC
  nT
end

function swap(A::Array{Int64}, i::Int64, j::Int64)
  tmp = A[i]
  A[i] = A[j]
  A[j] = tmp
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
  if s == "x"
    algorithm = "radixSort"
  elseif s == "r"
    algorithm = "randomizedSelect"
  else
    algorithm = "select"
  end
  i = 1; k = 100
  filename1 = string(algorithm, "_max_", n, "_arr_", sequence, ".txt")
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
  open(filename2, "w") do f
    while k <= n
      nc = arr[i].nC
      write(f, "$k $nc\n")
      k += 100
      i += 1
    end
  end
  filename = string(algorithm, "_max_", n, "_", sequence, ".png")
  if s == "x"
    run(`gnuplot -e "set term png; set output '$filename'; set xlabel 'SIZE OF DATA'; set ylabel 'NUMBER OF ARRANGEMENTS'; plot '$filename1' pt 60 notitle; set output"`)
  else
    run(`gnuplot -e "set term png; set output '$filename'; set xlabel 'SIZE OF DATA'; set ylabel 'NUMBER OF ARRANGEMENTS / COMPARISONS'; plot '$filename2' pt 20 title 'comparisons', '$filename1' pt 60 title 'arrangements'; set output"`)
  end
  filenameT = string(algorithm, "_max_", n, "_", sequence, "_time.txt")
  i = 1; k = 100
  open(filenameT, "w") do f
    while k <= n
      t = arr[i].nT
      write(f, "$k $t\n")
      k += 100
      i += 1
    end
  end
  filename = string(algorithm, "_max_", n, "_", sequence, "_time.png")
  run(`gnuplot -e "set term png; set output '$filename'; set xlabel 'SIZE OF DATA'; set ylabel 'TIME [s]'; plot '$filenameT' pt 20 notitle"`)

end

function exec(n::Int64, algorithm::String, sequence::String)
  r = Data[]
  k = 100
  j = 1
  max = 10

  if n <= 100
    A = rand(1:100000, n)
    if sequence == "desc"
      sortDesc(A)
    end
    if algorithm == "x"
      a, A = radixSort(A)
    elseif algorithm == "r"
      # randomizedSelect(A)
    else
      # select(A)
    end
    isSorted(A)
    println("\n", A)
  else
    while k <= n
      avgA = 0
      avgC = 0
      time = 0
      for i = 1 : max
        A = rand(1:100000, k)
        if sequence == "desc"
          sortDesc(A)
        end
        
        timeStart = Dates.datetime2unix(Dates.now())
        if algorithm == "x"
          a, A = radixSort(A)
          c = 0
        elseif algorithm == "r"
          #a, c = randomizedSelect(A)
        else
         # a, c = selec(A)
        end
        timeEnd = Dates.datetime2unix(Dates.now())

        time += timeEnd-timeStart
        avgA += a
        avgC += c
        isSorted(A)
      end
      avgA = div(avgA, max)
      avgC = div(avgC, max)
      avgTime = time/max
      push!(r, Data(avgA, avgC, avgTime))

      j += 1
      k += 100
    end
    plot(algorithm, r, n, sequence)
  end
end

println()
if length(ARGS) == 3
  n = try
    parse(Int64, ARGS[1])
  catch
    getMessage()
  end
  if n != nothing
    if n < 5
      println("Błąd: minimalny rozmiar danych ‒ 5 elementów")
    elseif ARGS[2] == "x" || ARGS[2] == "r" || ARGS[2] == "s"
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