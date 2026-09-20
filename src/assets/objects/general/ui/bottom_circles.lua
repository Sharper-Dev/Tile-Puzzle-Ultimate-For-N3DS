local GameObject = require("gameobject.m2d_gameobject")
local Script = require("scripts.general.ui.bottom_circles_script")

local thisObject = GameObject:new("bottom_circles")

local scriptComponent = thisObject:addComponent("Script")
thisObject:addComponent("Sprite")

scriptComponent.start = function()
    Script.start(thisObject)
end

scriptComponent.update = function ()
	Script.update(thisObject)
end

return thisObject