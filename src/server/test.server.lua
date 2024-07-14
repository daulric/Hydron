local Players = game:GetService("Players")
local Hydron = require(game.ReplicatedStorage.Hydron)

function Image(props)
    return Hydron.Create "Part" {
        Name = props.name,
        [Hydron.Event.TouchEnded] = props.touched,
        children = props.kids
    }
end

local element = Hydron.Create "Part" {
    Name = "TestGui",
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

local mounted = Hydron.Hydrate(element, workspace)
task.wait(10)
Hydron.Dehydrate(mounted)
task.wait(5)
Hydron.Hydrate(element, workspace)