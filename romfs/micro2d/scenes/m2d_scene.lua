--- A scene in the Micro2D engine.
--- @module scenes_scene
--- @author Sharper Dev

local Scene = {}
Scene.__index = Scene

--- The Scene Constructor.
--- @return Scene
--- @usage local scene = Scene:new("my_scene")
function Scene:new(name)
    self = setmetatable({}, Scene)
    self.gameObjects = {}
    self.name = name
    return self
end

--- Adds a game object to the scene.
--- @param gameObject GameObject
--- @return GameObject
--- @usage local gameObject = scene:addGameObject("path/to/object.lua")
function Scene:addGameObject(gameObject)
    table.insert(self.gameObjects, gameObject)
    gameObject.scene = self
    gameObject.index = #self.gameObjects

    return gameObject
end

--- Internal function to set up unload behavior for the scene.
function Scene:setupUnload()
    for i = 1, #self.gameObjects do
        self.gameObjects[i].enabled = false
    end
end

--- Unloads the scene, destroying all game objects.
--- This function is called when a scene transitions to another scene.
function Scene:unload()
    for i = 1, #self.gameObjects do
        self.gameObjects[i]:destroy()
    end
    for i = 1, #self.gameObjects do
        for j = 1, #self.gameObjects[i].components do
            setmetatable(self.gameObjects[i].components[j], nil)
            self.gameObjects[i].components[j] = nil
        end
        setmetatable(self.gameObjects[i], nil)
        self.gameObjects[i] = nil
    end
    self.gameObjects = nil
	self = nil
end
return Scene