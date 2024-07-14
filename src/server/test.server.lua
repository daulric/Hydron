local Players = game:GetService("Players")
local Hydron = require(game.ReplicatedStorage.Hydron)

local element = Hydron.Create "Part" {
    Name = "TestGui",
    [Hydron.Event "Touched"] = function(object)
        print(object.Name)
    end,

    [Hydron.Attribute "Hello"] = function(object: Instance)
        print(object:GetAttribute("Hello"))
    end,

    [Hydron.Change "Name"] = function(object)
        print("Name Changed to ", object.Name)
    end
}

Hydron.Hydrate(element, workspace):andThen(function(node)
    print(node)
end)