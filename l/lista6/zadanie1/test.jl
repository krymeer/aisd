include("heap.jl")
include("appendix.jl")

arr = [25, 50, 100, 500, 1000, 2000, 3000, 4000, 5000, 6000, 7000, 8000, 9000, 10000]

if length(ARGS) == 1
  if ARGS[1] == "insert"
    for i = 1 : 14
      totalC = 0
      for j = 1 : 100
        heap = Heap()
        for k = 1 : arr[i]-1
          insert(heap, rand(200:10000))
        end
        totalC += insert(heap, rand(1:199))
      end
      avg = Int64(floor(totalC/100))
      print(avg, "\r\n")
    end
  elseif ARGS[1] == "decrease"
    for i = 1 : 14
      totalC = 0
      for j = 1 : 100
        heap = Heap()
        for k = 1 : arr[i]
          insert(heap, rand(200:10000))
        end
        d = div(arr[i], 2)
        totalC += decreaseKey(heap, length(heap), 10)
      end
      avg = Int64(floor(totalC/100))
      print(avg, "\r\n")
    end
  elseif ARGS[1] == "extract"
    for i = 1 : 14
      totalC = 0
      for j = 1 : 100
        heap = Heap()
        for k = 1 : arr[i]
          insert(heap, rand(200:10000))
        end
        d = div(arr[i], 2)
        s, c = extractMin(heap)
        totalC += c
      end
      avg = Int64(floor(totalC/100))
      print(avg, "\r\n")
    end
  end
end