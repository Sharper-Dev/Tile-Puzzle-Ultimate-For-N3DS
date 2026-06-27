--- The ScenesManager module manages the loading and unloading of scenes in the game.
--- @module scenes_manager
--- @author Sharper Dev

local ScenesManager = {}
local settings = require("micro2d.m2d_settings")

function ScenesManager:loadScene(sceneIndex)
    local scenePath = settings.SCENES[sceneIndex]
end

return ScenesManager