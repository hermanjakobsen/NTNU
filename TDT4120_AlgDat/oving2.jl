function traversemax(record)
    highestValue = record.value
    nextNode = record.next
    while nextNode != nothing
    	if nextNode.value > highestValue
        	highestValue = nextNode.value
        end
        nextNode = nextNode.next
    end
    return highestValue
end
