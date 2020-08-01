
function parse_string(sentence::String)::Array{Tuple{String,Int}}
    string_array = split(sentence)
    tuples = Array{Tuple{String,Int}}(undef, length(string_array))
    letter_index = 1
    array_index = 1
    for word in string_array
        tuples[array_index] = (word, letter_index)
        letter_index += length(word) + 1
        array_index += 1
    end
    return tuples
end



#= ****** STRUCT ****** =#
struct Node
    children::Dict{Char,Node}
    posi::Array{Int}
end


function Node()
    Node() = Node(Dict(),[])
end

#= ****** End of struct ****** =#


function build(list_of_words::Array{Tuple{String,Int}})::Node
    rootnode = Node()
    for (word, index) in list_of_words # Går igjennom hvert tuple-par
        currentNode = rootnode
        for i = 1 : length(word)
            char = word[i]
             if haskey(currentNode.children, char) == false # Hvis keyen ikke eksisterer
                currentNode.children[char] = Node()
            end
            currentNode = currentNode.children[char] # Går til neste node
        end
        push!(currentNode.posi, index) # Er ved siste node så legger til index
    end
    return rootnode
end


function positions(word, node, index=1)
	char = word[index]

	if (haskey(node.children, char)) # Hvis keyen eksisterer
		node = node.children[char]
		if (index == length(word))
			return node.posi
		else
			index += 1
			return positions(word, node, index) # Iterer til neste node
		end
	elseif (char == '?')
		arr = []
		for pair in node.children # Go through every possible substitute char
			word = string(word[1:index-1], pair[1], word[index+1:length(word)]) # Replace only the first question mark if several
			append!(arr, positions(word, node, index)) # Do not increment index
		end
		return arr
	else
		return []
	end
end



#=
myTuples = parse_string("ene en eie ei ete et")
myTree = build(myTuples)
println(positions("e?e", myTree))
=#
