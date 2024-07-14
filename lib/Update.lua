local Hydrate = require(script.Parent:WaitForChild("Hydrate"))
local Dehydrate = require(script.Parent:WaitForChild("Dehydrate"))

return function (mountedNode, node)
    local currentNode = mountedNode.node
    local path = mountedNode.path

    currentNode.className = node.className
    currentNode.props = node.props
    currentNode.children = node.children
    currentNode._events = node._events

    Dehydrate(mountedNode)
    return Hydrate(node, path)
end