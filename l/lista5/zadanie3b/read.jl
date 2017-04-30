include("check.jl")

function readFile(filename::String)
  dict = Array{String,1}(1)
  open(filename) do f
    lines = readlines(f)
    empty = true
    for line in lines
      if empty
        dict[1] = line
        empty = false
      else 
        push!(dict, rstrip(line))
      end
    end
  end
  return dict
end

function readWords(dict::Array{String,1})
  while true
    word = rstrip(readline(STDIN))
    if word == "exit"
      quit()
    end
    if contains(word, " ")
      println("\nError: lines with more than one word are not allowed\n")
  else
      found = findSimilar(word, dict)
      if found == true
        println("\nYeah, that's right! You typed \"", word, "\" which is one of nearly 99000 words in the Unix dictionary\n")
      else
        println("\nDid you mean one of the words below?\n",
        found[1], ", ", found[2], ", ", found[3], "\n")
      end
    end
  end
end