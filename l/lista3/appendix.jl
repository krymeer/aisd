function toBinaryString(n::Int64)
  bitString = ""
  while n > 0
    bit = n % 2
    q = div(n, 2)
    bitString = string(bit, bitString)
    n = q
  end
  return bitString
end

function getMaximumNumberOfDigits(A::Array{Int64,1})
  n = length(A)
  max = A[1]
  for i = 2 : n
    if A[i] > max
      max = A[i]
    end
  end
  d = 0
  while max >= 1
    max /= 10
    d += 1
  end
  return d
end

function getMaximumLengthOfBinaryString(S::Array{String, 1})
  n = length(S)
  max = length(S[1])
  for i = 2 : n
    len = length(S[i])
    if len > max
      max = len
    end
  end
  return max
end

function toInt(s::String)
  a = 0; l = 0
  len = length(s)
  while l < len
    digit = s[len-l]
    if digit == '1'
      a += Int64(2^l)
    end
    l += 1
  end
  return a
end

function toIntArray(S::Array{String,1})
  n = length(S)
  A = zeros(Int64, n)

  for k = 1 : n
    A[k] = toInt(S[k])
  end

  return A
end

function addZeroPadding(S::Array{String,1}, d::Int64)
  n = length(S)
  for i = 1 : n
    while length(S[i]) < d
      S[i] = string("0", S[i])
    end
  end
end