local GameObject = require("gameobject.m2d_gameobject")
local InputSystem = require("systems.input.m2d_input_system")
local ScenesSystem = require("systems.scenes.m2d_scenes_system")

local GeneratorScript = dofile("romfs:/assets/scripts/objects/board/board_generator_script.lua")
local thisObject = GameObject:new("board")

local Script = thisObject:addComponent("Script")
thisObject:addComponent("Sprite")

Script.start = function()
    GeneratorScript.start(thisObject)
end

Script.update = function ()
	if InputSystem.getKeyDown(KEY_X) then
		ScenesSystem.loadScene(1)
	end
end
return thisObject