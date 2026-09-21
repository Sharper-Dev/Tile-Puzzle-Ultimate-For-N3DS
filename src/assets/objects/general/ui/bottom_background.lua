local GameObject = require("gameobject.m2d_gameobject")

local thisObject = GameObject:new("bottom_background")
local Sprite = thisObject:addComponent("Sprite")

thisObject.transform:setPosition(160, 120)
Sprite:setSprite("romfs:/assets/sprites/background/bg_bottom.png")
Sprite:setScreen(BOTTOM_SCREEN)
Sprite:setColor(43, 52, 65)

return thisObject