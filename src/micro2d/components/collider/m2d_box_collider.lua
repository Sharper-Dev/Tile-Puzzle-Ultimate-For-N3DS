--- A component that represents a box collider.
--- @module components_boxcollider
--- @author Sharper Dev

local BoxCollider = {}
BoxCollider.__index = BoxCollider

local CollisionSystem = require("systems.collision.m2d_collision_system")
local Debugger = require("debugger.m2d_debugger")
local Renderer = require("systems.renderer.m2d_renderer")
local RenderTask = require("systems.renderer.m2d_render_task")

--- BoxCollider constructor
--- @param gameObject The game object this collider is attached to.
function BoxCollider:new(gameObject)
    self = setmetatable({}, BoxCollider)

    self.enabled = true
    self.name = "BoxCollider"
    self.gameObject = gameObject
    self:setSize(10, 10)
    self:setOffset(0, 0)
    self.enteredCollisions = {}
    self.ignoreMetaLayers = {}
    self.collisionLayer = 1
    self.metaCollisionLayer = 1
    CollisionSystem.registerCollider(self.collisionLayer, self)
    self.renderTask = RenderTask:new({
        layer = 1,
        execute = function() self:render() end
    })
    Renderer.registerRenderTask(self.renderTask, BOTTOM_SCREEN, Renderer.SPACES.SCREEN)
    return self
end

--- Sets the layer of the collider.
--- @param layer The layer to set.
function BoxCollider:setLayer(layer)
    CollisionSystem.registerCollider(layer, self)
    CollisionSystem.unregisterCollider(self.collisionLayer, self)
    self.collisionLayer = layer
end

--- Sets the meta layer of the collider.
--- @param layer The meta layer to set.
function BoxCollider:setMetaLayer(layer)
    self.metaCollisionLayer = layer
end

--- Inserts a meta layer to ignore.
--- @param metaLayer The meta layer to ignore.
function BoxCollider:insertIgnoreMetaLayer(metaLayer)
    table.insert(self.ignoreMetaLayers, metaLayer)
end

--- Removes a meta layer to ignore.
--- @param metaLayer The meta layer to remove.
function BoxCollider:removeIgnoreMetaLayer(metaLayer)
    for i, layer in ipairs(self.ignoreMetaLayers) do
        if layer == metaLayer then
            table.remove(self.ignoreMetaLayers, i)
            return
        end
    end
end

--- Creates a gizmos for the collider.
function BoxCollider:render()
    if not Debugger.isEnabled() then return end

    local positionx = self.gameObject.transform.position.x
    local positiony = self.gameObject.transform.position.y
    positionx = positionx + self.xoffset
    positiony = positiony + self.yoffset
    Graphics.fillEmptyRect(positionx, self.width + positionx, positiony, self.height + positiony,
        Color.new(0, 255, 0))
end

--- Clean up the collider and remove it from the collision system.
function BoxCollider:destroy()
    CollisionSystem.unregisterCollider(self.collisionLayer, self)
    Renderer.unregisterRenderTask(self.renderTask, BOTTOM_SCREEN, Renderer.SPACES.SCREEN)
	self.gameObject = nil
    self.renderTask = nil
    self.enabled = nil
    self = nil
end
--- Sets the size of the collider.
--- @param width The width of the collider.
--- @param height The height of the collider.
function BoxCollider:setSize(width, height)
    self.width = width
    self.height = height
end

--- Sets the offset of the collider.
--- @param x The x offset of the collider.
--- @param y The y offset of the collider.
function BoxCollider:setOffset(x, y)
    self.xoffset = x
    self.yoffset = y
end

--- Called when the collider enters a collision.
--- @param collider The getted collider
function BoxCollider:onCollisionEnter(collider) end

--- Called when the collider stays in a collision.
--- @param collider The getted collider
function BoxCollider:onCollisionStay(collider) end

--- Called when the collider exits a collision.
--- @param collider The getted collider
function BoxCollider:onCollisionExit(collider) end

--- Called when the collider is touched down.
function BoxCollider:onTouchDown() end

--- Called when the collider stays touched.
function BoxCollider:onTouchStay() end

--- Called when the collider is clicked.
function BoxCollider:onTouchClick() end

--- Called when the collider is released.
function BoxCollider:onTouchUp() end

return BoxCollider