--- A scene in the Micro2D engine.
--- @module m2d_scenes_scene
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

return Scene