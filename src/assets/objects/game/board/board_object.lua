local GameObject = require("gameobject.m2d_gameobject")
local InputSystem = require("systems.input.m2d_input_system")
local ScenesSystem = require("systems.scenes.m2d_scenes_system")
local CollisionSystem = require("systems.collision.m2d_collision_system")
local BoardChecker = require("scripts.objects.board.board_checker_script")
local Debugger = require("debugger.m2d_debugger")

local GeneratorScript = dofile("romfs:/assets/scripts/objects/board/board_generator_script.lua")
local thisObject = GameObject:new("board")

local Script = thisObject:addComponent("Script")
thisObject:addComponent("Sprite")

function thisObject.callCheck()
    if BoardChecker.check(thisObject) then
        Debugger.msg("SOLVED!")
        CollisionSystem.setLayerActive(1, false)
    end
end

Script.start = function()
    GeneratorScript.start(thisObject)
end

Script.update = function()
    if InputSystem.getKeyDown(KEY_X) then
        ScenesSystem.loadScene(1)
    end
end

return thisObject