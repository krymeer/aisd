function split(A::Array{Int64}, n::Int64)
    lenAa = div(n, 2)
    lenAb = lenAa
    if n % 2 != 0
        lenAa += 1
    end
    Aa = zeros(Int64, lenAa)
    Ab = zeros(Int64, lenAb)
    j = 1
    for i = 1 : lenAa
        Aa[i] = A[i]
        j += 1
    end
    i = 1
    while i <= lenAb && j <= n
        Ab[i] = A[j]
        i += 1
        j += 1
    end
    return Aa, Ab
end

function merge(B::Array{Int64}, C::Array{Int64})
    lenB = length(B); lenC = length(C)
    # println("MS: scalenie dwóch tablic o długości ", lenB, " i ", lenC)
    numA = 0; numC = 0
    A = zeros(Int64, lenB+lenC)
    i = 1; j = 1; k = 1
    # println("MS: porównanie B[", i, "] = ", B[i] ," i C[", j, "] = ", C[j])
    while i <= lenB && j <= lenC
        if (B[i] <= C[j])
            # println("MS: A[", k, "] = B[", i, "] = ", B[i])
            A[k] = B[i]
            i += 1
        else # B[i] > C[j]
            # println("MS: A[", k, "] = C[", j, "] = ", C[j])
            A[k] = C[j]
            numA += 1
            j += 1
        end
        numC += 1
        k += 1
    end
    while i <= lenB # jeśli pozostały jakieś elementy w tablicy B
        # println("MS: A[", k, "] = B[", i, "] = ", B[i])
        A[k] = B[i]
        numA += 1
        i += 1
        k += 1
    end
    while j <= lenC # jeśli pozostały jakieś elementy w tablicy C
        # println("MS: A[", k, "] = C[", j, "] = ", C[j])
        A[k] = C[j]
        j += 1
        k += 1
    end
    return numA, numC, A
end

function mergeSort(A::Array{Int64}, n::Int64)
    if n == 1
        return 0, 0, A # liczba przestawień, liczba porównań, tablica
    else
        B, C = split(A, n) 
        ba, bc, B = mergeSort(B, length(B))
        ca, cc, C = mergeSort(C, length(C))
        a, c, A = merge(B, C)
        a += ba+ca
        c += bc+cc
    end
    return a, c, A
end

function mergeSort(A::Array{Int64})
    return mergeSort(A, length(A))
end