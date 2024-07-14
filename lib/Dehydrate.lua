local Players = game:GetService("Players")

function DestroyNodes(node)
    for i, v in pairs(node.children) do
        if v.children then
            DestroyNodes(v)
        end

        if v._object then
            v._object.Parent = nil
            task.wait()
            v._object:Destroy()
        end

        if v._parent then
            v._parent = nil
        end
    end

    node._parent = nil
    node._object.Parent = nil
    node._object:Destroy()
end

return function (mountedNode)
    if mountedNode.mounted == true then
        DestroyNodes(mountedNode.node)
        mountedNode.mounted = nil
    end
end