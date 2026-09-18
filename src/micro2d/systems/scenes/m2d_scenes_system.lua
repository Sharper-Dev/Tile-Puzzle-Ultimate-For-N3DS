--- Manages the loading and unloading of scenes in the game.
--- @module systems_scenes
--- @author Sharper Dev

local ScenesSystem = {}
local activeScenes = {}
local readyScenes = {}

local universalScene

--- Loads a scene by index, unloading any active scenes first.
--- @param sceneIndex The index of the scene to load.
--- @usage ScenesSystem.loadScene(1)
function ScenesSystem.loadScene(sceneIndex)
    for i, _ in ipairs(activeScenes) do
        ScenesSystem.unloadScene(i)
    end

    local scenePath = M2D_SETTINGS.SCENES[sceneIndex]
    local scene = dofile(scenePath)
    table.insert(activeScenes, scene)
    table.insert(readyScenes, scene)
end

function ScenesSystem.startReadyScenes()
    for i = 1, #readyScenes do
        local scene = readyScenes[i]
        for _, object in ipairs(scene.gameObjects) do
            for _, component in ipairs(object.components) do
                if component.start then
                    component:start()
                end
            end
        end
    end
    readyScenes = {}
end

--- Returns the universal scene.
function ScenesSystem.getUniversalScene()
    return universalScene
end

--- Internal function to load the universal scene.
function ScenesSystem.loadUniversalScene()
	universalScene = dofile("romfs:/micro2d/assets/scenes/m2d_universal_scene.lua")
	for i = 1, #universalScene.gameObjects do
		local object = universalScene.gameObjects[i]
		for _, component in ipairs(object.components) do
			if component.start then
				component:start()
			end
		end
	end
end

--- Unloads a scene by index, destroying all game objects.
--- @param sceneIndex The index of the scene to unload.
--- @usage ScenesSystem.unloadScene(1)
function ScenesSystem.unloadScene(sceneIndex)
    if activeScenes[sceneIndex] then
        local Runtime = require("core.m2d_core_runtime")
        activeScenes[sceneIndex]:setupUnload()
        Runtime.requestUnload(activeScenes[sceneIndex])
    end
    collectgarbage("collect")
end

function ScenesSystem.removeSceneFromTable(index)
    table.remove(activeScenes, index)
end

--- Returns the active scenes.
--- @return The active scenes.
--- @usage local scenes = ScenesSystem.getActiveScenes()
function ScenesSystem.getActiveScenes()
    return activeScenes
end

return ScenesSystem