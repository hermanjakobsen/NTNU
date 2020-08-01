function counting_sort_letters(A, position)
    highest_char = 'a'
    for i = 1 : length(A)
        word = A[i]
        if (word[position] > highest_char)
            highest_char = word[position]
        end
    end
    correction = 96  #Make a = 1 and b = 2 etc
    k = Int(highest_char) - correction
    C = Array{Int64}(undef, k)
    B = Array{String}(undef, length(A))
    for i = 1 : k
        C[i] = 0
    end
    for j = 1 : length(A)
        word = A[j]
        C[Int(word[position]) - correction] = C[Int(word[position]) - correction] + 1
    end
    for i = 2 : k
        C[i] = C[i] + C[i-1]
    end
    for j = length(A) : -1: 1
        word = A[j]
        B[C[Int(word[position]) - correction]] = word
        C[Int(word[position]) - correction] = C[Int(word[position]) - correction] - 1
    end
    return B

end



function counting_sort_length(A)
    longest_string = ""
    for j = 1 : length(A)
        if (length(A[j]) >= length(longest_string))
            longest_string = A[j]
        end
    end
    k = length(longest_string)
    C = Array{Int64}(undef, k +1)
    B = Array{String}(undef, length(A))
    for i = 1 : k + 1
        C[i] = 0
    end
    for j = 1 : length(A)
        C[length(A[j])+1] = C[length(A[j])+1] + 1
    end
    for i = 2 : k + 1
        C[i] = C[i] + C[i-1]
    end
    for j = length(A) : -1: 1
        B[C[length(A[j])+1]] = A[j]
        C[length(A[j])+1] = C[length(A[j])+1] - 1
    end
    return B
end

function flexradix(A, max_length)
    sorted_array = counting_sort_length(A)
    word_length = length(A[1])
    C = Array{Int64}(undef, max_length + 1)
    for i = 1 : max_length + 1
        C[i] = 0
    end
    for j = 1 : length(A)
        C[length(A[j])+1] = C[length(A[j])+1] + 1
    end
    for i = 2 : max_length + 1
        C[i] = C[i] + C[i-1]
    end
    println(C)
    for i = max_length : -1 : 1
        


    end

    return sorted_array
end



array = ["kobra", "aggie", "agg", "kort", "hyblen"]
println(flexradix(array, 6))
