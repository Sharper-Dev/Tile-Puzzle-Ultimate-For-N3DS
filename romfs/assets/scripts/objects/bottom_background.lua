local GameObject = require("gameobject.m2d_gameobject")

local thisObject = GameObject:new("bottom_background")
local Script = thisObject:addComponent("Script", {})
local Sprite = thisObject:addComponent("Sprite", "romfs:/assets/sprites/screens/bg_bottom.png")

function Script:start()
    thisObject.transform:setPosition(160, 120)
    Sprite:setScreen(BOTTOM_SCREEN)
    Sprite:setColor(43, 52, 65)
end

return thisObject