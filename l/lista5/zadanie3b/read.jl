include("check.jl")
ccall(:jl_exit_on_sigint, Void, (Cint,), 0)

function readFile(filename::String)
  dict = Array{String,1}(1)
  open(filename) do f
    lines = readlines(f)
    empty = true
    for line in lines
      if empty
        dict[1] = rstrip(line)
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
    try
      if eof(STDIN)
        quit()
      end
      word = rstrip(readline(STDIN))
      if contains(word, " ")
        println("\nError: lines with more than one word are not allowed\n")
      elseif word != ""
        found = findSimilar(word, dict)
        if found == true
        println("\nYeah, that's right! You typed \"", word, "\" which is one of nearly 99000 words in the Unix dictionary\n")
        else
          println("\nDid you mean one of the words below?\n",
          found[1], ", ", found[2], ", ", found[3], "\n")
        end
      end
    catch exception
      if (isa(exception, InterruptException))
        println()
        quit()
      end
    end
  end
end