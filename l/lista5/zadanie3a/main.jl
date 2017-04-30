include("algo.jl")

function stats()
  alphabet = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
  j = 0
  for k = 0 : 20
    X = ""
    for i = 1 : 20+j
      X *= rand(alphabet[1:26])
    end
    Y = ""
    for i = 1 : 25+j
      Y *= rand(alphabet[1:26])
    end
    ed, numberOfComparisons = editDistance(X, Y)
    j += 1000
    print(k, "\t", length(X), "\t", length(Y), "\t", length(X)+length(Y), "\t", numberOfComparisons, "\r\n")
  end
end

if length(ARGS) >= 1 && ARGS[1] == "true"
  stats()
else
  str1 = "POLYNOMIAL"#"SNOWY"
  str2 = "EXPONENTIAL"#"SUNNY"
  ed, ctr = editDistance(str1, str2)
  println("\neditDistance(\"", str1, "\", \"", str2, "\") = ", ed, "\nLiczba porównań: ", ctr, "\n")
end