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

--- Unloads the scene, destroying all game objects.
--- This function is called when a scene transitions to another scene.
function Scene:unload()
    for _, gameObject in ipairs(self.gameObjects) do
        gameObject:destroy()
    end
	
	self.gameObjects = nil
end
return Scene