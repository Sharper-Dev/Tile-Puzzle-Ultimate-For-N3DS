local GameObject = require("gameobject.m2d_gameobject")
local GeneratorScript = require("scripts.objects.board.board_generator_script")

local thisObject = GameObject:new("board")

local Script = thisObject:addComponent("Script")
thisObject:addComponent("Sprite")

Script.start = function ()
	GeneratorScript.start(thisObject)
end

return thisObject