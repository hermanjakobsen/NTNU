#= ***** Used to test miscellaneous functions ***** =#
mutable struct Node
    id::Int
    neighbours::Array{Node}
    color::Union{String, Nothing}
    distance::Union{Int, Nothing}
    predecessor::Union{Node, Nothing}
end

Node(id) = Node(id, [], nothing, nothing, nothing)

#= ***** Task 1 ***** =#
function makenodelist(adjacencylist)
    nodes = Array{Node}(undef, length(adjacencylist))

    # Create all nodes with right ID and put them in array
    for i = 1 : length(adjacencylist)
        newNode = Node(i)
        nodes[i] = newNode
    end

    # Give the nodes correct neighbours
    # Node i has neighbours corresponding to the array lying at adjacencylist[i]
    for i = 1 : length(nodes)
        nodeNeighbours = Array{Node}(undef, length(adjacencylist[i]))
        for j = 1 : length(adjacencylist[i])
            neighbourNodeID = adjacencylist[i][j]
            nodeNeighbours[j] = nodes[neighbourNodeID]
        end
        nodes[i].neighbours = nodeNeighbours
    end
    return nodes
end


#= ***** Used to gain access to QUEUE ***** =#
  # using Pkg
  # Pkg.add("DataStructures")
  # using DataStructures

#= ***** Task 2 ***** =#
function bfs!(nodes, start)
    # Edge case
    if isgoalnode(start)
        return start
    end
    # Iterate through all the nodes and set init values
    for node in nodes
        node.color = "white"
        node.distance = typemax(Int)
        node.predecessor = nothing
    end
    # Set init values for startNode
    start.color = "gray"
    start.distance = 0
    start.predecessor = nothing # Redundant
    # Initialize the queue
    q = Queue{Node}()
    enqueue!(q, start)
    # Runs as long as there is a node in the queue
    while !isempty(q)
        u = dequeue!(q)
        # Check all the neighbourNodes to u and put them in queue if first time discovered
        # Also give the struct variables correct value
        for node in u.neighbours
            if node.color == "white"
                node.color = "gray"
                node.distance = u.distance + 1
                node.predecessor = u
                enqueue!(q, node)
            end
            if isgoalnode(node)
                # Return the node we are searching for
                return node
            end

        end
        u.color = "black"
    end
    # The node we are searching does not exist
    return nothing
end

#= ***** Task 3 ***** =#
function makepathto(goalnode)
    currentNode = goalnode
    path = Int64[] # Empty array which will contain NodeIDs

    # Runs as long as a node has a predecessor. Will end up at the startNode
    # Puts the different NodeIDs in the path array
    while currentNode.predecessor != nothing
        push!(path, currentNode.id)
        currentNode = currentNode.predecessor
    end
    # Must remember to add the last node in the path (startNode)
    push!(path, currentNode.id)
    # The path array is now in reversed order. Must thererfore reverse it
    reversedPath = Int64[]
    for i = length(path) : -1: 1
        push!(reversedPath, path[i])
    end
    return reversedPath
end

adjacencylist = [[2, 3], [3], [4], []]
nodes = makenodelist(adjacencylist)
bfs!(nodes, nodes[1])
