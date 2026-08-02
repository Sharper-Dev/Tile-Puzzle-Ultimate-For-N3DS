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
    gameObject.scene = self
    gameObject.index = #self.gameObjects
    return gameObject
end

function Scene:getHierarchy()
	local hierarchy = {}
	for _, gameObject in ipairs(self.gameObjects) do
		table.insert(hierarchy, gameObject)
		for _, child in ipairs(gameObject.transform.children) do
			table.insert(hierarchy, child)
		end
	end
	return hierarchy
end
function Scene:unload()
	for _, gameObject in ipairs(self.gameObjects) do
		gameObject:destroy()
	end
	self.gameObjects = nil
end
return Scene