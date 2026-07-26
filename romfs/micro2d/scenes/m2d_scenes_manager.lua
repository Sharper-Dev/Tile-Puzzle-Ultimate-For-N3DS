--- The ScenesManager module manages the loading and unloading of scenes in the game.
--- @module scenes_manager
--- @author Sharper Dev

local ScenesManager = {}
local activeScenes = {}

function ScenesManager.loadScene(sceneIndex)
    for i, scene in ipairs(activeScenes) do
        ScenesManager.unloadScene(i)
    end
    local scenePath = M2D_SETTINGS.SCENES[sceneIndex]
    local scene = dofile(scenePath)
    table.insert(activeScenes, scene)
    for _, obj in ipairs(scene.gameObjects) do
        for _, component in ipairs(obj.components) do
            component:start()
        end
    end
end

function ScenesManager.unloadScene(sceneIndex)
    if activeScenes[sceneIndex] then
        activeScenes[sceneIndex]:unload()
        table.remove(activeScenes, sceneIndex)
    end
end

function ScenesManager.getActiveScenes()
    return activeScenes
end

return ScenesManager