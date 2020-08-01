#= ***** Used to test miscellaneous functions ***** =#
mutable struct Node
    ip::Int
    neighbours::Array{Tuple{Node,Int}}
    risk::Union{Float64, Nothing}
    predecessor::Union{Node, Nothing}
    probability::Float64
end

#= ***** Task 1 ***** =#
function initialize_single_source!(graph, start)
    # Initialize the two variables that the task demands to be initialized
    for node in graph
        node.risk = typemax(Float64)
        node.predecessor = nothing
    end
    start.risk = 0;
end


#= ***** Task 2 ***** =#
function relax!(fromNode,toNode,cost)
    # Calculate risk from given formula
    newRisk = fromNode.risk + (cost / toNode.probability)
    # Check if the new risk is less than the previous
    # The risk should be equal to the new risk if this is the case
    # Predecessor should then be set accordingly
    if toNode.risk > newRisk
        toNode.risk = newRisk
        toNode.predecessor = fromNode
    end
end


#= ***** Used to gain access to PRIORITYQUEUE ***** =#
   using Pkg
  # Pkg.add("DataStructures")
   using DataStructures


#= ***** Task 3 ***** =#
function dijkstra!(graph,start)
    # Initialize
    initialize_single_source!(graph, start)
    finishedNodes = Node[]
    nodeQueue = PriorityQueue{Node, Float64}()
    # Put nodes in queue based on their risk
    # Lowest value of risk gets dequeued first which is wanted
    for node in graph
        enqueue!(nodeQueue, node, node.risk)
    end
    while !isempty(nodeQueue)
        # Dequeue the node with lowest risk
        node = dequeue!(nodeQueue)
        push!(finishedNodes, node)
        for i = 1 : length(node.neighbours)
            neighbour = node.neighbours[i][1]
            cost = node.neighbours[i][2]
            relax!(node, neighbour, cost)
            # If the node is not finished, must update it's risk
            # This to ensure that the priorityQueue dequeues nodes in the right order
            if !(neighbour in finishedNodes)
                nodeQueue[neighbour] = neighbour.risk
            end
        end
    end
end

#= ***** Task 4 ***** =#
function bellman_ford!(graph,start)
    # Initialize
    initialize_single_source!(graph, start)
    # Iterate through all edges and relax them
    # Means relaxing all neighbours to every node
    # All edges should be relaxed length(graph) - 1
    # to ensure that all nodes have shortest path
    for i = 1 : length(graph) - 1
        for node in graph
            for j = 1 : length(node.neighbours)
                neighbour = node.neighbours[j][1]
                cost = node.neighbours[j][2]
                relax!(node, neighbour, cost)
            end
        end
    end
    # By using a last iteration, check that no changes occur
    # This ensures that we do not have negative-weight cycles
    for node in graph
        for i = 1 : length(node.neighbours)
            neighbour = node.neighbours[i][1]
            cost = node.neighbours[i][2]
            newRisk = node.risk + (cost / neighbour.probability)
            if neighbour.risk > newRisk
                # Have a change. This implies a negative-weight cycle
                return false
            end
        end
    end
    return true
end
