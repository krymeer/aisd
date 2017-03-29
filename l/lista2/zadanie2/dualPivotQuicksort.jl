function dualPivotQuicksort(A::Array{Int64,1}, left::Int64, right::Int64)
  numA = 0; numC = 0
  if right > left
    # Dla małych tablic można skorzystać z sortowania przez wstawianie
    if right-left <= 27
      return partialInsertionSort(A, left, right)
    else
      # Wybór skrajnych elementów jako pivoty
      numC += 1
      if A[left] > A[right]
        numA += 1
        swap(A, left, right)
      end
      p = A[left]
      q = A[right]
      l = left+1; g = right-1; k = l
      while k <= g
        # Elementy mniejsze od 1. pivota trafiają za niego
        numC += 1
        if A[k] < p
          numA += 1
          swap(A, k, l)
          l += 1
        # Elementy większe od 2. pivota go poprzedzają
        elseif A[k] >= q
          while A[g] > q && k < g
            numC += 1
            g -= 1
          end
          numA += 1
          swap(A, k, g)
          g -= 1
          # Nowy element z indeksem k zostaje przesunięty do
          # początkowej części, jeżeli jest mniejszy od pivota
          numC += 1
          if A[k] < p
            numA += 1
            swap(A, k, l)
            l += 1
          end
        end
        k += 1
      end
      l -= 1
      g += 1
      # Wstawienie pivotów na odpowiednie pozycje
      numA += 2
      swap(A, left, l)
      swap(A, right, g)
      # Rekurencyjne posortowanie partycji
      ax, cx = dualPivotQuicksort(A, left, l-1)
      ay, cy = dualPivotQuicksort(A, l+1, g-1)
      az, cz = dualPivotQuicksort(A, g+1, right)
      numA += ax+ay+az
      numC += cx+cy+cz
    end
  end
  return numA, numC  
end

function dualPivotQuicksort(A::Array{Int64,1})
  return dualPivotQuicksort(A, 1, length(A))
end