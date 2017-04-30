include("lcs.jl")


alphabet = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
println(length(alphabet))
X = ["P", "O", "L", "Y", "N", "O", "M", "I", "A", "L"]
Y = ["E", "X", "P", "O", "N", "E", "N", "T", "I", "A", "L"]

c, n, numberOfComparisons = LCSlength(X, Y)

println("Długość najdłuższego podciągu: ", n)
println("Najdłuższy wspólny podciąg: \"", getLCS(c, X, Y), "\"")

j = 0
for k = 0 : 20
  X = Array{String,1}(20+j)
  for i = 1 : 20+j
    X[i] = rand(alphabet[1:26])
  end
  Y = Array{String,1}(25+j)
  for i = 1 : 25+j
    Y[i] = rand(alphabet[1:26])
  end
  c, n, numberOfComparisons = LCSlength(X, Y)
  j += 1000
  println(k, "\t", length(X), "\t", length(Y), "\t", length(X)+length(Y), "\t", numberOfComparisons)
end