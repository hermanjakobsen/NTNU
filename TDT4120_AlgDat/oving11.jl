#= ***** Task 1 ***** =#
function floyd_warshall(adjacency_matrix, nodes, f, g)
    # the for-loop range equals number of rows in adjacency_matrix
    # This is equivalent to the number of nodes
    for k = 1 : nodes
        for i = 1 : nodes
            for j = 1 : nodes
                # Make variables for nodes
                d_ij = adjacency_matrix[i, j]
                d_ik = adjacency_matrix[i, k]
                d_kj = adjacency_matrix[k, j]
                # Update the distance with the given functions f and g
                result = f(d_ij, g(d_ik, d_kj))
                # Update the matrix
                adjacency_matrix[i, j] = result
            end
        end
    end
    return adjacency_matrix
end

#= ***** Task 2 ***** =#
# Run first floyd_warshall to create a matrix containing all weighted paths between nodes
# The main idea is A[i, j] == Inf --> False, other values --> true
function transitive_closure(adjacency_matrix, nodes)
    A = floyd_warshall(adjacency_matrix, nodes, min, +)
    T = Array{Bool}(undef, nodes, nodes)
    for i = 1 : nodes
        for j = 1 : nodes
            if A[i, j] == Inf
                T[i, j] = false
            else
                T[i, j] = true
            end
        end
    end
    return T
end

#= ***** Task 3 ***** =#
# It is possible to implement this function much more efficiently than what is done here
# However, I think the logic behind this imoplementation is pretty easy to follow
function create_preference_matrix(ballots, voters, candidates)
    # Make a (voters x voters) sized matrix
    pMatrix = Array{Int64}(undef, candidates, candidates)
    # Initialize
    for i = 1 : candidates
        for j = 1 : candidates
            pMatrix[i, j] = 0
        end
    end
    for i = 1 : candidates
        mainCandidateName = 'A' + i - 1
        # Have the candidate in focus
        # Must find out how many times he/she beats the other candidates
        for j = 1 : candidates
            # Ensure that the main candidate is not also the second candidate
            if (i != j)
                secondCandidateName = 'A' + j - 1
                # Have the candidate that we will compare with main candidate
                # Will compare by iterating through every ballot and check indexes
                mainCandidateNameIndex = -1
                secondCandidateNameIndex = -1
                timesBeaten = 0
                for k = 1 : voters
                    ballot = ballots[k]
                    # Iterate through ballot and find the two indexes
                    for l = 1 : length(ballot)
                        if (mainCandidateName == ballot[l])
                            mainCandidateNameIndex = l
                        end
                        if (secondCandidateName == ballot[l])
                            secondCandidateNameIndex = l
                        end
                    end
                    # Count if the main candidate beat the second candidate
                    if mainCandidateNameIndex < secondCandidateNameIndex
                        timesBeaten += 1
                    end
                end
                # Have how many times the main candidate beat the second candidate
                # Must put this value correctly in the pmatrix
                pMatrix[i, j] = timesBeaten
            end
        end
    end
    return pMatrix
end


#= ***** Task 4 ***** =#
function find_strongest_paths(preference_matrix, candidates)
    # First, copy the preference_matrix
    pMatrix = Array{Int64}(undef, candidates, candidates)
    for i = 1 : candidates
        for j = 1 : candidates
            pMatrix[i, j] = preference_matrix[i, j]
        end
    end
    # Then, remove the weakest edge between each pair of nodes
    for i = 1 : candidates
        for j = 1 : candidates
            # Erase both if the edges are equally strong
            if (pMatrix[i, j] == pMatrix[j, i])
                pMatrix[i, j] = 0
                pMatrix[j, i] = 0
            elseif (pMatrix[i, j] > pMatrix[j, i])
                pMatrix[j, i] = 0
            else
                pMatrix[i, j] = 0
            end
        end
    end
    return (floyd_warshall(pMatrix, candidates, max, min))
end


#= ***** Task 5 ***** =#
# The idea is to let the index of each candidate represent how many people who have beaten them
# and then put them into an array in this order
# Lastly, iterate through the array and convert to a string
function find_schulze_ranking(strongest_paths, candidates)
    # candidatesOrdered should contain the candidates ordered after who they beat
    candidatesOrdered = Array{Char}(undef, candidates)
    for i = 1 : candidates
        mainCandidateName = 'A' + i - 1
        # Initialized to 1 because of 1-indexing
        beatenByOther = 1
        for j = 1 : candidates
            # Ensure that the main candidate is not also the second candidate
            if (i != j)
                secondCandidateName = 'A' + i - 1
                # mainCandidateName is beaten by secondCandidateName
                if (strongest_paths[i, j] < strongest_paths[j, i])
                    beatenByOther += 1
                end
            end
        end
        # Have how many times each candidate is beaten
        # Must put the candidate in right position in candidatesOrdered
        candidatesOrdered[beatenByOther] = mainCandidateName
    end
    # Must convert the array into a string
    orderedString = ""
    for i = 1 : candidates
        orderedString *= candidatesOrdered[i]
    end
    return orderedString
end

preference_matrix = [0 1 2; 2 0 2; 1 1 0]
candidates = 3
println(find_strongest_paths(preference_matrix, candidates))
