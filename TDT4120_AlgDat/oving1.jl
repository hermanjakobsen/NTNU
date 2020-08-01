
function insertionsort!(arr)
  for j in 2:length(arr)
    key = arr[j]
    i = j - 1
      while i > 0 && arr[i] > key
        arr[i + 1] = arr[i]
        i = i - 1
      end
    arr[i+1] = key
  end
end

array = [5, 1, 4, 1, 5]

insertionsort!(array)
print(array)
