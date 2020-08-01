function bisect_right(A, p, r, v)
  i = p
  if p < r
    q = floor(Int, (p+r)/2)
    if v >= A[q]
      i = bisect_right(A, q+1, r, v)
    else
      i = bisect_right(A, p, q, v)
    end
  end
  return i
end

function bisect_left(A, p, r, v)
    i = p
    if p < r
       q = floor(Int, (p+r)/2)
       if v <= A[q]
           i = bisect_left(A, p, q, v)
       else
           i = bisect_left(A, q+1, r, v)
       end
    end
    return i
end

function partition!(A, p, r)
  x = A[r]
  i = p - 1
  for j = p : r - 1
    if A[j] <= x
      i = i + 1
      # exchange A[i] with A[j]
      temp = A[i]
      A[i] = A[j]
      A[j] = temp
    end
  end
  # exchange A[i+1] with A[r]
  temp = A[i + 1]
  A[i + 1] = A[r]
  A[r] = temp
  return i+1
end

function algdat_sort!(A)
  algdat_sort2(A, 1, length(A))
end


function algdat_sort2!(A, p, r) # Quicksort
  if p < r
    q = partition!(A, p, r)
    algdat_sort2!(A, p, q-1)
    algdat_sort2!(A, q+1, r)
  end
end

function find_median(A, lower, upper)
  lower_index = bisect_left(A, 1, length(A), lower)
  upper_index = bisect_right(A, 1, length(A), upper)
  if A[upper_index] > upper
    upper_index = upper_index - 1
  end
  interval_length = upper_index - lower_index + 1
  correction = lower_index - 1
  if (upper_index - lower_index + 1) % 2 != 0
    return A[floor(Int, interval_length / 2) + 1 + correction]
  else
    lower_value = A[Int((interval_length / 2) + correction)]
    upper_value = A[Int((interval_length / 2) + correction + 1)]
    return (upper_value + lower_value) / 2
  end
end

list2 = [5, 5, 1, 1, 8, 8, 4, 3, 1, 7, 7]
algdat_sort!(list2, 1, 11)
