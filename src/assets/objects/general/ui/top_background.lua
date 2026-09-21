local GameObject = require("gameobject.m2d_gameobject")

local thisObject = GameObject:new("top_background")
local Sprite = thisObject:addComponent("Sprite")

thisObject.transform:setPosition(200, 120)
Sprite:setSprite("romfs:/assets/sprites/background/bg_top.png")
Sprite:setScreen(TOP_SCREEN)
Sprite:setColor(43, 52, 65)

return thisObject