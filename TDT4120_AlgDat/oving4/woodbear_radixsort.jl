
# Counting sort for strings
# func is function giving out value to sort based on, should give 0 for smallest value and k for biggest value
function counting_sort(A, k, func)
	C = zeros(Int, k + 1) #C[1..k+1]
	B = Array{String}(undef, length(A)) #B[1..A.length]

	# Makes C[i] contain the number of elements equal to i
	for j in 1:length(A)
		val = func(A[j])
		C[val + 1] += 1
	end

	# Makes C[i] contain the number of elements less than or equal to i
	for i in 2:k+1
		C[i] += C[i - 1]
	end

	# Places each string in the correct position
	for j in length(A):-1:1
		val = func(A[j])
		B[C[val + 1]] = A[j]
		C[val + 1] -= 1
	end

	return B
end


#Counting sort on strings based on a specific character position
function counting_sort_letters(A, pos)
	k = 'z' - 'a' # Value range is [0..k]

	return counting_sort(A, k, x -> x[pos] - 'a')
end


# Counting sort on strings based on length
function counting_sort_length(A)
	# Finds the longest string
	maxlength = length(A[1])
	for i in 1:length(A)
		maxlength = max(maxlength, length(A[i]))
	end

	k = maxlength # Value range is [0..k]

	return counting_sort(A, k, x -> length(x))
end


# First sort all the strings based on length,
# then start on the biggest index(given by maxlength) and go down to the smallest
# index and use counting sort to sort only the strings that have that given index
function flexradix(A, maxlength)
	# B shall be sorted Array
	# C is array keeping track of number of strings with a certain length
	B = counting_sort_length(A)
	C = zeros(Int, maxlength + 1)

	#println("B=", B)

	# Makes C[i + 1] contain the number of strings with length i
	# Ex. C[1] contains the number of strings with length 0
	# C[maxlength + 1] contains the strings with length maxlength
	for i in 1:length(B)
		C[length(B[i]) + 1] += 1
	end

	#println("C=", C)

	# Makes C reverse cummulative
	# C[i + 1] now contains the number of strings with length i or larger
	# Ex. C[1] contains the number of strings with length 0 or larger
	# C[maxlength - 1 + 1] contains the number of strings with length (maxlength - 1) or larger
	for i in length(C)-1:-1:1
		C[i] += C[i + 1]
	end

	#println("C=", C)

	# Start on index maxlength and go down to index 1
	# and sort all the strings which are long enough to have index i
	# Don't change the place and sorting of the strings which are not long enough (must be stable)
	for i in maxlength:-1:1
		#println("i=", i)

		# D is a temporary array used to temporary store the strings with a certain length
		# D must be large enough to store all the strings which are long enough to have index i
		# C[i + 1] gives how many strings that are long enough to have index i
		D = Array{String}(undef, C[i + 1])

		#println("D=", D)

		# Copy from B array to D array the strings that are long enough to have index i
		# The first string which are long enough are in B at index
		# (length(B) - number of strings which are long enough + 1)

		D = B[length(B) - C[i + 1] + 1:length(B)] # Slicing variant
		# Loop variant:
		# for j in 1:C[i + 1]
		# 	D[j] = B[length(B) - C[i + 1] + j]
		# end

		#println("D=", D)

		# Sort D array based on index i,
		# aka sort the strings which are long enough to have index i based on letter at index i
		D = counting_sort_letters(D, i)

		#println("D=", D)

		# Copy the sorted strings back to B array
		# It's important to not effect the strings which are not sorted so the algorithm is stable
		B[length(B) - C[i + 1] + 1: length(B)] = D # Slicing variant
		# Loop variant:
		for j in 1:C[i + 1]
			B[length(B) - C[i + 1] + j] = D[j]
		end

		#println("B=", B)
	end
	return B
end
