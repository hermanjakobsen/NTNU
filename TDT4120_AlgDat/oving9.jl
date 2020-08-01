#= ***** Used to test miscellaneous functions ***** =#
module StructDisjointSetNode
export DisjointSetNode
    mutable struct DisjointSetNode
        rank::Int
        p::DisjointSetNode
        # Inner construction method
        # new() creates an object if type DisjointSetNode with the rank as argument (?)
        DisjointSetNode() = (obj = new(0); obj.p = obj;)
    end
end
using .StructDisjointSetNode

#= ***** Task 1 ***** =#
function findset(x::DisjointSetNode)
    # Check if node has itself as predecessor (Top node)
    if x != x.p
        # Checking recursive with path compression
        # All nodes on the path will end up with the top node as predecessor
        x.p = findset(x.p)
    end
    return x.p
end

#= ***** Task 2 ***** =#
# Starting out with defining help function
# Connects two rootnodes and maintains the rank heuristic
function link!(x::DisjointSetNode, y::DisjointSetNode)
    if x.rank > y.rank
        # The x node will be the new rootnode
        y.p = x
    else
        # The y node will be the new rootnode
        x.p = y
        if x.rank == y.rank
            # Must maintain the rank heuristic
            y.rank += 1
        end
    end
end

# Find the rootnodes of a set and connect them
# Note: Needed to rename the function because union is a built-in function of some sort
function union1!(x::DisjointSetNode, y::DisjointSetNode)
    link!(findset(x), findset(y))
end

#= ***** Task 3 ***** =#
function hammingdistance(s1::String, s2::String)
    if length(s1) != length(s2)
        # Safety precaution
        return -1
    end
    distance = 0
    # Checks all letters
    for i = 1 : length(s1)
        # If the letters are not identical, plus one to the distance
        if (s1[i] != s2[i])
            distance += 1
        end
    end
    return distance
end

#= ***** Task 4 ***** =#
# Define help-function to merge subarrays in an array
function mergeTrees!(trees, u , v)
    # Find index of the two trees u, v
    uIndex = -1
    vIndex = -1
    for i = 1 : length(trees)
        if u in trees[i]
            uIndex = i
        end
        if v in trees[i]
            vIndex = i
        end
    end
    # Merge the two trees
    # Could have used append()
    mergedTree = Int64[]
    for i = 1 : length(trees[uIndex])
        push!(mergedTree, trees[uIndex][i])
    end
    for i = 1 : length(trees[vIndex])
        push!(mergedTree, trees[vIndex][i])
    end
    # Delete the two "old" trees and insert the new one
    # Would only have to delete one tree if append() alternative has been used
    deleteat!(trees, uIndex)
    if (uIndex < vIndex && vIndex != 1)
        vIndex -= 1
    end
    deleteat!(trees, vIndex)
    push!(trees, mergedTree)
end


# The function will base itself on Kruskal's algorithm
function findclusters(E::Vector{Tuple{Int, Int, Int}}, n::Int, k::Int)
    # Array which will contain all the different trees
    trees = Array{Int64}[]
    # Initialize the array.
    # Each node will at the start be its own tree (represented as integers)
    for i = 1 : n
        push!(trees, [i])
    end
    # Sort the tuples in nondecreasing order
    # Edge with lowest weight will appear first
    sort!(E)
    # Create an array which contains the nodes
    nodes = DisjointSetNode[]
    for i = 1 : n
        push!(nodes, DisjointSetNode())
    end
    # Iterate through all edges
    # Stop when we have k trees
    # This implies length(trees) == k
    for i = 1 : length(E)
        # Create variables for the nodes between an edge
        u = E[i][2]
        v = E[i][3]
        # Note: u and v are integers
        if length(trees) == k
            break
        end
        # Checks if the nodes are part of different trees
        if findset(nodes[u]) != findset(nodes[v])
            # Connect them into a tree
            union1!(nodes[u], nodes[v])
            # Merge the subarrays in trees so it corresponds to the union
            mergeTrees!(trees, u, v)
        end
    end
    return trees
end

#= ***** Task 5 ***** =#
function findanimalgroups(animals::Vector{Tuple{String, String}}, k::Int64)
    numberOfNodes = length(animals)
    E = Tuple{Int64, Int64, Int64}[]
    # Create a pair (edge) between each node with corresponding weight
    # A node must not make a pair (edge) with itself
    for i = 1 : numberOfNodes - 1
        for j = i + 1 : numberOfNodes
            # Calculate weight between the nodes
            weight = hammingdistance(animals[i][2], animals[j][2])
            # Create a edge and add to E
            edge = (weight, i, j)
            push!(E, edge)
        end
    end
    # Make clusters
    clusters = findclusters(E, numberOfNodes, k)
    # Must transform the integers from the previous cluster
    # into corresponding animal-string
    animalCluster = Array{String}[]
    # Checking each cluster
    for i = 1 : length(clusters)
        stringNode = String[]
        # Checking each node
        for j = 1: length(clusters[i])
            animalInteger = clusters[i][j]
            animalName = animals[animalInteger][1]
            push!(stringNode, animalName)
        end
        push!(animalCluster, stringNode)
    end
    return animalCluster
end
