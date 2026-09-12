local GameObject = require("gameobject.m2d_gameobject")
local ScenesManager = require("scenes.m2d_scenes_manager")
local thisObject = GameObject:new("board")

local Script = thisObject:addComponent("Script")
local Sprite = thisObject:addComponent("Sprite")

local pieceObject
function Script.start()
    thisObject.transform:setPosition(160, 120, 2)
    Sprite:setSprite("romfs:/assets/sprites/board/board.png")
    Sprite:setScreen(BOTTOM_SCREEN)
    local Debugger = require("debugger.m2d_debugger")

    Debugger.msg("Active scene: " .. ScenesManager.getActiveScenes()[1].name)
    GameObject.instantiate(dofile("romfs:/assets/scripts/game/piece/piece.lua"))
end

return thisObject