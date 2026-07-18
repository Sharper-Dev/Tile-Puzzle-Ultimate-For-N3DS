--- The ScenesManager module manages the loading and unloading of scenes in the game.
--- @module scenes_manager
--- @author Sharper Dev

local ScenesManager = {}
local settings = require("m2d_settings")
local currentScene = nil

function ScenesManager.loadScene(sceneIndex)
    if currentScene then
        currentScene:unload()
    end
    local scenePath = settings.SCENES[sceneIndex]
    -- local success, scene = pcall(dofile, scenePath)
    -- if not success then
    --     error("Failed to load scene: " .. scenePath)
    -- end
    local scene = dofile(scenePath)
    currentScene = scene
    for _, obj in ipairs(currentScene.gameObjects) do
        for _, component in ipairs(obj.components) do
            component:start()
        end
    end
end

function ScenesManager.getCurrentScene()
    return currentScene
end

return ScenesManager