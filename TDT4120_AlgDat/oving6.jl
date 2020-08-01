
#= ***** Oppgave 1 ***** =#

function cumulative(weights)
    rows, cols = size(weights)
    path_weights = copy(weights)
    for i = 2 : rows
        for j = 1 : cols
            path_weights[i, j] = calculate_weight(i, j, rows, cols, path_weights) #Dynamisk programmering!!!!
        end
    end
    return path_weights
end



function calculate_weight(row, col, maxRow, maxCol, matrix)
    elemWeight = matrix[row, col]
    if (row == 1)
        return elemWeight
    end
    minValue = matrix[row-1, col]
    for j = col - 1 : col + 1
        if (j >= 1 && j <= maxCol && (matrix[row-1, j] < minValue)) # Innenfor matrisen og den er minst
            minValue = matrix[row-1, j]
        end
    end
    return elemWeight + minValue
end


#= ***** Oppgave 2 ***** =#

function back_track(path_weights)
    rows, cols = size(path_weights)
    shortestPath = Array{Tuple{Int,Int}}(undef, rows)
    minIndexCol = cols
    minWeight = path_weights[rows, cols]

    # Start-case, minste og lengst til venstre i nederste rad
    for i = 1 : cols
        if (path_weights[rows,i] < path_weights[rows, minIndexCol])
            minIndexCol = i
        end
    end
    shortestPath[1] = (rows, minIndexCol)

    for i = rows - 1 : -1 : 1
        for j = minIndexCol - 1 : minIndexCol + 1
            if (j >= 1 && j <= cols && (path_weights[i, j] < path_weights[i, minIndexCol])) # Innenfor matrisen og den er minst
                    minIndexCol = j
            end
        end
        shortestPath[rows - i + 1] = (i, minIndexCol) # Dynamisk Programmering
    end
    return shortestPath
end
