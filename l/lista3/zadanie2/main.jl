include("randomizedSelect.jl")
include("select.jl")
include("appendix.jl")

function getMessage()
  println("Użycie:\n\n\tzadanie2.jl liczbaElementów algorytmSortowania typDanychWejściowych ktaStatystyka\n\n\talgorytmSortowania:\n\t   r ‒ randomized select\n\t   s ‒ select\n\n\ttypDanychWejściowych:\n\t   perm ‒ permutacja liczb od 1 do liczbaElementów\n\t   rand ‒ losowy ciąg\n\n\tktaStatystyka:\n\t   k-ty najmniejszy element tablicy")
end

function exec(n::Int64, algorithm::String, sequence::String, kIndex::Int64)
  k = 0
  kMax = 1000
  cMin = 0; cSum = 0; cMax = 0;

  for k = 1 : kMax
    A = Array{Int64,1}
    if sequence == "perm"
      A = collect(1:n)
      permute(A)
    else
      A = rand(1:1000, n)
    end
    if k == 1
      println(A)
    end
    if algorithm == "r"
      c, v = randomizedSelect(A, kIndex)
    else
      c, v = select(A, kIndex)
    end
    if c < cMin
      cMin = c
    elseif c > cMax
      cMax = c
    end
    cSum += c
    if k == 1
      cMin = c
      cMax = c
      println("\n", A, "\n\n", kIndex, ". statystyką pozycyjną tablicy jest: ", v)
      println("\nNaciśnij ENTER, aby kontynuować")
      readline(STDIN)
    end
    quickSort(A)
    isSorted(A)
    if k == 1
      println(A, "\n\nUwaga: w celu zachowania czytelności w kolejnych wywołaniach komunikaty nie będą wyświetlane")
    end
  end
  println("\nLiczba porównań:\n  min\t  max\t  avg\n  ", cMin, "\t  ", cMax, "\t  ", Int64(round(cSum/kMax)))

end


println()
if length(ARGS) == 4
  n = try
    parse(Int64, ARGS[1])
  catch
    getMessage()
  end
  if n != nothing
    if n < 5
      println("Błąd: minimalny rozmiar danych ‒ 5 elementów")
    elseif  ARGS[2] == "r" || ARGS[2] == "s"
      if ARGS[3] == "perm" || ARGS[3] == "rand"
        m = try
          parse(Int64, ARGS[4])
        catch
          getMessage()
        end
        if m != nothing
          if m <= 0 || m > n
            getMessage()
          else
            exec(n, ARGS[2], ARGS[3], m)
          end
        end
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