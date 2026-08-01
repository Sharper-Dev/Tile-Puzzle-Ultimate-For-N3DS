--- A scene in the Micro2D engine.
--- @module scenes_scene
--- @author Sharper Dev

local Scene = {}
Scene.__index = Scene

function Scene:new()
    local this = setmetatable({}, Scene)
    this.gameObjects = {}
    setmetatable(this, {__index = Scene})
    return this
end

function Scene:addGameObject(gameObject)
    table.insert(self.gameObjects, gameObject)
end
function Scene:unload()
	for _, gameObject in ipairs(self.gameObjects) do
		gameObject:destroy()
	end
	self.gameObjects = nil
end
return Scene