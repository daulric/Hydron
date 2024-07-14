local EventTable = {
    Attribute = {},
    Event = {},
    Change = {},
}

EventTable.__index = EventTable

function CreateType(type)
    if EventTable[type] ~= nil then
        local eventLog = EventTable[type]
        setmetatable(eventLog, {
            __index = function(self, index)
                local listener = {
                    eventName = index,
                    Type = type,
                }

                setmetatable(listener, {
                    __tostring = function(self)
                        return (`{self.Type}`)
                    end
                })

                return listener

            end
        })
    end
end

CreateType("Event")
CreateType("Change")
CreateType("Attribute")

return EventTable