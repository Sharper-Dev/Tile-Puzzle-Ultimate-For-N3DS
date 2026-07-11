--- The ScenesManager module manages the loading and unloading of scenes in the game.
--- @module scenes_manager
--- @author Sharper Dev

local ScenesManager = {}
local settings = require("m2d_settings")
local currentScene = nil

function ScenesManager.loadScene(sceneIndex)
    local scenePath = settings.SCENES[sceneIndex]
    local success, scene = pcall(dofile, scenePath)
    --dofile(scenePath)
    if not success then
        error("Failed to load scene: " .. scenePath)
    end
    currentScene = scene
    scene:start()
end

function ScenesManager.getCurrentScene()
    return currentScene
end
return ScenesManager