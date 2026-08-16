local GameObject = require("gameobject.m2d_gameobject")

local thisObject = GameObject:new("top_background")
local Script = thisObject:addComponent("Script", {})
local Sprite = thisObject:addComponent("Sprite", "romfs:/assets/sprites/background/bg_top.png")

function Script:start()
    thisObject.transform:setPosition(200, 120)
    Sprite:setScreen(TOP_SCREEN)
    Sprite:setColor(43, 52, 65)
end

return thisObject