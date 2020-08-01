#= ***** Task 1 ***** =#
function certifysubsetsum(set, subsetindices, s)
    sum = 0
    for i = 1 : length(subsetindices)
        sum += set[subsetindices[i]]
    end
    return (sum == s)
end


#= ***** Task 2 ***** =#
#??????????
function certifytsp(path, maxweight, neighbourmatrix)
    weight = 0
    for i = 1 : length(path) - 1
        currentNode = path[i]
        nextNode = path[i+1]
        weight += neighbourmatrix[currentNode, nextNode]
        #println("currentnode: ", currentNode)
        #println("nextNode: ", nextNode)
        #println("edge weight: ", neighbourmatrix[currentNode, nextNode])
        #println("total weight: ", weight)
    end
    return (weight <= maxweight)
end

path = [3, 1, 2, 3]
maxweight = 42
neighbourmatrix = [-1 1 14; 4 -1 4; 42 42 -1]

#println(certifytsp(path, maxweight, neighbourmatrix))


#= ***** Task 3 ***** =#
function alldistinct(list)
    sort!(list)
    for i = 1 : length(list) -1
        if (list[i] == list[i+1])
            return false
        end
    end
    return true
end

list = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 9]
println(alldistinct(list))

#= ***** Task 4 ***** =#
