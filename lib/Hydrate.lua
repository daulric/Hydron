local EventAttributes = require(script.Parent:WaitForChild("Event"))
local Promise = require(script.Parent:WaitForChild("promise"))
local Refer = require(script.Parent:WaitForChild("Ref"))

function HandleEvents(object: Instance, event: {eventName: string, Type: string}, func: (...any) -> (), _eventLogs: { [string]: RBXScriptConnection })

    if type(func) ~= "function" then
        error(`Hydron: Invalid Function passed for {event} `)
    end

    local eventConnection;

    if event.Type == "Event" then
        if typeof(object[event.eventName]) == "RBXScriptSignal" then
            eventConnection = object[event.eventName]:Connect(function(...)
                func(object, ...)
            end)
        end
    elseif event.Type == "Change" then
        eventConnection = object:GetPropertyChangedSignal(event.eventName):Connect(function(...)
            func(object, ...)
        end)
    elseif event.Type == "Attribute" then
        eventConnection = object:GetAttributeChangedSignal(event.eventName):Connect(function(...)
            func(object, ...)
        end)
    end

    _eventLogs[event] = eventConnection;
end

function HandleProps(element)
    local props = element.props

    element._object = Instance.new(element.className)

    for i, v in pairs(props) do
        if type(i) == "table" and i.Type ~= nil then
            HandleEvents(element._object, i, v, element._events)
        elseif i == Refer.Ref then
            v.current = element._object
            v.isRefed = true
        elseif type(i) == "string" and i:lower() == "children" then
            continue
        else
            element._object[i] = v
        end
    end

    if element.children then
        for i, v in pairs(element.children) do
            HandleProps(v)
            v._object.Parent = element._object
        end
    end

    return element
end

return function (node, path)
    local handleObject = HandleProps(node)

    if handleObject._object then
        handleObject._object.Parent = path
    end

    return {
        mounted = true,
        node = handleObject,
        path = path,
    }
end