--- A component that represents a box collider.
--- @module components_collider
--- @author Sharper Dev

local BoxCollider = {}
BoxCollider.__index = BoxCollider
local CollisionSystem = require("systems.collision.m2d_collision_system")
local Debugger = require("debugger.m2d_debugger")
local Renderer = require("renderer.m2d_renderer")
local RenderTask = require("renderer.m2d_render_task")

function BoxCollider:new(gameObject)
    self = setmetatable({}, BoxCollider)

    self.enabled = true
    self.name = "BoxCollider"
    self.gameObject = gameObject
    self:setSize(10, 10)
    self:setOffset(0, 0)
    CollisionSystem.registerCollider(1, self)
    self.renderTask = RenderTask:new({
        layer = 1,
        execute = function() self:render() end
    })
    Renderer.addRenderTask(self.renderTask, BOTTOM_SCREEN, Renderer.SPACES.SCREEN)
    return self
end

function BoxCollider:render()
    if not Debugger.isEnabled() then return end

    local positionx = self.gameObject.transform.position.x
    local positiony = self.gameObject.transform.position.y
    positionx = positionx + self.xoffset
    positiony = positiony + self.yoffset
    Graphics.fillEmptyRect(positionx, self.width + positionx, positiony, self.height + positiony,
        Color.new(0, 255, 0))
end

function BoxCollider:setSize(width, height)
    self.width = width
    self.height = height
end

function BoxCollider:setOffset(x, y)
    self.xoffset = x
    self.yoffset = y
end

-- function BoxCollider:onCollisionEnter(gameObject) end
-- function BoxCollider:onCollisionStay(gameObject) end
-- function BoxCollider:onCollisionExit(gameObject) end

function BoxCollider:onTouchDown() end
function BoxCollider:onTouchStay() end
function BoxCollider:onTouchUp() end

return BoxCollider