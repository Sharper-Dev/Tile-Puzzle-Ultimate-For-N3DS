local GameObject = require("gameobject.m2d_gameobject")

local thisObject = GameObject:new("top_title")
local Script = thisObject:addComponent("Script")
local Sprite = thisObject:addComponent("Sprite")

function Script:start()
    thisObject.transform:setPosition(200, 120, 1)
    Sprite:setSprite("romfs:/assets/sprites/title/title.png")
    Sprite:setScreen(TOP_SCREEN)
end

return thisObject