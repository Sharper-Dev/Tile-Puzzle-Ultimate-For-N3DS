--- A component that represents a box collider.
--- @module components_collider
--- @author Sharper Dev

local BoxCollider = {}
BoxCollider.__index = BoxCollider
local CollisionEngine = require("collision.m2d_collision_engine")

function BoxCollider:new(gameObject)
    self = setmetatable({}, BoxCollider)

    self.enabled = true
    self.name = "BoxCollider"
    self.gameObject = gameObject
    self:setSize(10, 10)
    self:setOffset(0, 0)
    CollisionEngine.insertCollider(1, self)
    return self
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