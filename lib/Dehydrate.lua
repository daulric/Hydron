local ref = require(script.Parent:WaitForChild("Ref")).Ref

function DestroyNodes(node)
    for i, v in pairs(node.children) do
        if v.children then
            DestroyNodes(v)
        end

        if v.props[ref] then
            v.props[ref].current = nil
            v.props[ref].isRefed = false
        end

        if v._object then
            v._object.Parent = nil
            v._events = {}
            task.wait()
            v._object:Destroy()
        end

        if v._parent then
            v._parent = nil
        end
    end

    if node.props[ref] then
        node.props[ref].current = nil
        node.props[ref].isRefed = false
    end

    node._parent = nil
    node._object.Parent = nil
    node._object:Destroy()
end

return function (mountedNode)
    if mountedNode.mounted == true then
        DestroyNodes(mountedNode.node)
        mountedNode.path = nil
        mountedNode.mounted = nil
    end
end