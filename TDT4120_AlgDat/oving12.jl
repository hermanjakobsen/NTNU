#= ***** Used to test miscellaneous functions ***** =#
function find_augmenting_path(source, sink, nodes, flows, capacities)

  function create_path(source, sink, parent)
    # creates a path from source to sink using parent list
    node = sink
    path = Vector{Int}([sink])
    while node ≠ source
      node = parent[node]
      push!(path, node)
    end
    return reverse(path)
  end

  discovered = zeros(Bool, nodes)
  parent = zeros(Int, nodes)
  queue = Queue{Int}()
  enqueue!(queue, source)

  # BFS to find augmenting path, while keeping track of parent nodes
  while !isempty(queue)
    node = dequeue!(queue)
    if node == sink
      return create_path(source, sink, parent)
    end

    for neighbour ∈ 1:nodes
      if !discovered[neighbour] && flows[node, neighbour] < capacities[node, neighbour]
        enqueue!(queue, neighbour)
        discovered[neighbour] = true
        parent[neighbour] = node
      end
    end
  end

  return nothing # no augmenting path found
end

function max_path_flow(path, flows, capacities)
  # find max flow to send through a path
  n = length(path)
  flow = Inf
  for i in 2:n
    u, v = path[i-1], path[i]
    flow = min(flow, capacities[u, v] - flows[u, v])
  end
  return flow
end

function send_flow!(path, flow, flows)
  n = length(path)
  for i in 2:n
    u, v = path[i-1], path[i]
    flows[u, v] += flow
    flows[v, u] -= flow
  end
end


#= ***** Task 1 ***** =#
# ????????????????????
function max_flow(source, sink, nodes, capacities)
    # Initialize flow matrix and total flow
    flows = zeros(Int, nodes, nodes)
    totalFlow = 0
    # Run as long as there is an augmenting path
    augmentingPath = find_augmenting_path(source, sink, nodes, flows, capacities)
    while (augmentingPath != nothing)
        # Find the maximal flow that can be sent on the augmenting path
        maxPathFlow = max_path_flow(augmentingPath, flows, capacities)
        # Update the flows on the augmenting path
        send_flow!(path, maxPathFlow, flows)
        # Find a new augmenting path
        augmentingPath = find_augmenting_path(source, sink, nodes, flows, capacities)
    end
    # Total flow will be the flow out from the source
    # Equivalent, the flow into the sink
    for i = 1 : nodes
        totalFlow += flows[source, i]
    end
    # Should return total flow as a tuple?
    return flows, totalFlow
end


#= ***** Task 2 ***** =#
# First, find the max flow
# The minimal cut can now be found by traversing the residual graph
# from the source to all reachable nodes.
function min_cut(source, sink, nodes, capacities)
    flows, totalFlow = max_flow(source, sink, nodes, capacities)


end
