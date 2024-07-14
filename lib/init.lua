-- Services
local RunService = game:GetService("RunService")

if RunService:IsClient() then
    warn("Can't Be Used on the Client!")
    return {}
end

local Event = require(script:WaitForChild("Event"))
local Create = require(script:WaitForChild("Create"))
local Hydrate = require(script:WaitForChild("Hydrate"))
local Dehydrate = require(script:WaitForChild("Dehydrate"))
local Update = require(script:WaitForChild("Update"))
local Ref = require(script:WaitForChild("Ref"))

local Hydron = {
    Create = Create,
    Hydrate = Hydrate,
    Dehydrate = Dehydrate,
    Update = Update,

    -- Events Signals
    Attribute = Event.Attribute,
    Event = Event.Event,
    Change = Event.Change,

    -- Ref
    Ref = Ref.Ref,
    useRef = Ref.useRef,
}

return Hydron