local Players = game:GetService("Players")
local Hydron = require(game.ReplicatedStorage.Hydron)

local PartRef = Hydron.useRef()

function Image(props)
    return Hydron.Create "Part" {
        Name = props.name,
        [Hydron.Event.TouchEnded] = props.touched,
        children = props.kids
    }
end

local element = Hydron.Create "Part" {
    Name = "TestGui",

    [Hydron.Ref] = PartRef,

    [Hydron.Event.Touched] = function(object)
        print(object.Name)
    end,

    [Hydron.Event.TouchEnded] = function(object)
        print(object.Name, "idk ended!")
    end,

    [Hydron.Attribute.Hello] = function(object: Instance)
        print(object:GetAttribute("Hello"))
    end,

    [Hydron.Change.Name] = function(object)
        print("Name Changed to ", object.Name)
    end,

    children = {
        Decal = Hydron.Create "Decal" {
            Name = "Image Caster!"
        },

        Function = Hydron.Create(Image) {
            name = "idk",
            touched = function(object)
                print(object)
            end,
            kids = {
                Hydron.Create(Image) {
                    name = "idk another nested!",
                    touched = function(object)
                        print("Image Nested 2")
                    end
                }
            }
        }
    }
}

local upgradedElement = Hydron.Create "Part" {
    Name = "Updated Part",

    children = {
        Decon = Hydron.Create(Image) {
            name = "Update Event Part",
            touched = function(object)
                print(object, "updated!")
            end
        }
    }
}

local mounted = Hydron.Hydrate(element, workspace)
print(PartRef.current)

task.wait(10)
mounted = Hydron.Update(mounted, upgradedElement)
print("New Mounted:", mounted)
--[[Hydron.Dehydrate(mounted)
task.wait(5)
Hydron.Hydrate(element, workspace)]]