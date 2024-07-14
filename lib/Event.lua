function CreateType(type, eventName)
    return {
        Type = type,
        eventName = eventName
    }
    
end

function Event(eventName)
    return CreateType("Event", eventName)
end

function Change(eventName)
    return CreateType("Change", eventName)
end

function Attribute(eventName)
    return CreateType("Attribute", eventName)
end

return {
    Event = Event,
    Change = Change,
    Attribute = Attribute
}