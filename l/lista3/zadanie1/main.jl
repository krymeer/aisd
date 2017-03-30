include("radixSort.jl")

function getMessage()
  println("Użycie:\n\n\tzadanie3.jl liczbaElementów typDanychWejściowych\n\n\ttypDanychWejściowych:\n\t   desc ‒ ciąg posortowany malejąco\n\t   rand ‒ losowy ciąg\n\nAlgorytm sortujący: radix sort")
end

type Data
  nA
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

function plot(arr::Array{Data,1}, n::Int64, sequence::String)
  i = 1; k = 100
  filename1 = string("radixSort_max_", n, "_arr_", sequence, ".txt")
  open(filename1, "w") do f
    while k <= n
      na = arr[i].nA
      write(f, "$k $na\n")
      k += 100
      i += 1
    end
  end
  filename = string("radixSort_max_", n, "_", sequence, ".png")
  run(`gnuplot -e "set term png; set output '$filename'; set xlabel 'SIZE OF DATA'; set ylabel 'NUMBER OF ARRANGEMENTS'; plot '$filename1' pt 60 notitle; set output"`)
  filenameT = string("radixSort_max_", n, "_", sequence, "_time.txt")
  i = 1; k = 100
  open(filenameT, "w") do f
    while k <= n
      t = arr[i].nT
      write(f, "$k $t\n")
      k += 100
      i += 1
    end
  end
  filename = string("radixSort_max_", n, "_", sequence, "_time.png")
  run(`gnuplot -e "set term png; set output '$filename'; set xlabel 'SIZE OF DATA'; set ylabel 'TIME [s]'; plot '$filenameT' pt 20 notitle"`)

end

function exec(n::Int64, sequence::String)
  r = Data[]
  k = 100
  j = 1
  max = 10

  if n <= 100
    A = rand(1:100000, n)
    if sequence == "desc"
      sortDesc(A)
    end
    a, A = radixSort(A)
    isSorted(A)
    println("\n", A)
  else
    while k <= n
      avgA = 0
      time = 0
      for i = 1 : max
        A = rand(1:100000, k)
        if sequence == "desc"
          sortDesc(A)
        end
        
        timeStart = Dates.datetime2unix(Dates.now())
        a, A = radixSort(A)
        timeEnd = Dates.datetime2unix(Dates.now())

        time += timeEnd-timeStart
        avgA += a
        isSorted(A)
      end
      avgA = div(avgA, max)
      avgTime = time/max
      push!(r, Data(avgA, avgTime))

      j += 1
      k += 100
    end
    plot(r, n, sequence)
  end
end

println()
if length(ARGS) == 2
  n = try
    parse(Int64, ARGS[1])
  catch
    getMessage()
  end
  if n != nothing
    if n < 5
      println("Błąd: minimalny rozmiar danych ‒ 5 elementów")
    elseif ARGS[2] == "desc" || ARGS[2] == "rand"
      exec(n, ARGS[2])
    else
      getMessage()
    end
  end
else
  getMessage()
end
println()