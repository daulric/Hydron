-- Services
local RunService = game:GetService("RunService")

if RunService:IsClient() then
    warn("Can't Be Used on the Client!")
    return {}
end

local Event = require(script:WaitForChild("Event"))
local Create = require(script:WaitForChild("Create"))
local Hydrate = require(script:WaitForChild("Hydrate"))
local Event = require(script:WaitForChild("Event"))

local Hydron = {
    Create = Create,
    Hydrate = Hydrate,

    Attribute = Event.Attribute,
    Event = Event.Event,
    Change = Event.Change,
}

return Hydron