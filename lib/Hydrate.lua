local EventAttributes = require(script.Parent:WaitForChild("Event"))
local Promise = require(script.Parent:WaitForChild("promise"))

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

    for i, v in pairs(props) do
        if type(i) == "table" and i.Type ~= nil then
            HandleEvents(element._object, i, v, element._events)
        else
            element._object[i] = v
        end

    end
end

function HandleObject(node)
    HandleProps(node)
    return node
end

return function (node, path)
    return Promise.new(function(resolve)
        local handleObject = HandleObject(node)

        if handleObject._object then
            handleObject._object.Parent = path
        end

        print("Hydration Complete!")
        resolve(handleObject)
    end)
end