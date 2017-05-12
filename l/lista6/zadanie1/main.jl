include("heap.jl")
include("appendix.jl")

heap = Heap()
insert(heap, 112)
insert(heap, 56)
insert(heap, 32)
insert(heap, 19)
insert(heap, 18)
insert(heap, 17)
insert(heap, 16)
insert(heap, 33)

println("\nKopiec:")

printHeap(heap)

A = [16, 4, 10, 14, 7, 9, 3, 2, 8, 1]
println("\nNowy kopiec z tablicy ", A, ": ")

buildHeap(A)
printHeap(A)

decreaseKey(A, 100, 20)
decreaseKey(A, 1, 16)

println("\ndecreaseKey na 8. elemencie kolejki (", A[8], "):")
decreaseKey(A, 8, 6)
printHeap(A)

println("\nPobranie z kolejki najmniejszego elementu (", A[1], "):")
extractMin(A)
printHeap(A)

println()