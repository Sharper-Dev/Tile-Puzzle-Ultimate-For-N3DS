--- The Scenes Manager module manages the loading and unloading of scenes in the game.
--- @module scenes_manager
--- @author Sharper Dev

local ScenesManager = {}
local activeScenes = {}

--- Loads a scene by index, unloading any active scenes first.
--- @param sceneIndex The index of the scene to load.
--- @usage ScenesManager.loadScene(1)
function ScenesManager.loadScene(sceneIndex)
    for i, _ in ipairs(activeScenes) do
        ScenesManager.unloadScene(i)
    end
    local scenePath = M2D_SETTINGS.SCENES[sceneIndex]
    local scene = dofile(scenePath)
    table.insert(activeScenes, scene)
    for _, object in ipairs(scene.gameObjects) do
        for _, component in ipairs(object.components) do
            if component.start then
                component:start()
            end
        end
    end
end

--- Unloads a scene by index, destroying all game objects.
--- @param sceneIndex The index of the scene to unload.
--- @usage ScenesManager.unloadScene(1)
function ScenesManager.unloadScene(sceneIndex)
    if activeScenes[sceneIndex] then
        local Runtime = require("core.m2d_core_runtime")
        activeScenes[sceneIndex]:setupUnload()
        Runtime.requestUnload(activeScenes[sceneIndex])
        table.remove(activeScenes, sceneIndex)
    end
    collectgarbage("collect")
end

--- Returns the active scenes.
--- @return The active scenes.
--- @usage local scenes = ScenesManager.getActiveScenes()
function ScenesManager.getActiveScenes()
    return activeScenes
end

return ScenesManager