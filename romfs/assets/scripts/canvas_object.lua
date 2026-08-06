local GameObject = require("gameobject.m2d_gameobject")

local thisObject = GameObject:new("Canvas")
thisObject:addComponent("Canvas", BOTTOM_SCREEN)

return thisObject