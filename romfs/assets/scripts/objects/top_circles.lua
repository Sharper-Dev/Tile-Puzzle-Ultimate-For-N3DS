local GameObject = require("gameobject.m2d_gameobject")

local thisObject = GameObject:new("top_circles")
local Script = thisObject:addComponent("Script", {})
local Sprite = thisObject:addComponent("Sprite", "romfs:/assets/sprites/background/circles.png")

function Script:start()
    thisObject.transform:setPosition(250, 201, 1)
    Sprite:setScreen(TOP_SCREEN)
end

return thisObject