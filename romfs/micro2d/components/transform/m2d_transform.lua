--- The GameObject transform.
--- @module components_transform
--- @author Sharper Dev

local Transform = {}
Transform.__index = Transform

--- Functions
--- @section functions

--- The transform constructor.
--- @param gameObject m2d_gameobject GameObject this transform belongs to.
--- @return self transform
function Transform:new(gameObject)
    self = setmetatable({}, Transform)
    self.gameObject = gameObject
    self.position = { x = 0, y = 0, z = 0 }
    self.rotation = 0
    self.scale = { x = 1, y = 1 }

    return self
end

--- Sets the position of this transform.
-- @param x number
-- @param y number
-- @param z number
--- @return self transform
--- @usage
--- thisObject.transform:setPosition(0, 0, 0)
function Transform:setPosition(x, y, z)
    self.position.x = x or self.position.x
    self.position.y = y or self.position.y
    self.position.z = z or self.position.z

    return self
end

--- Sets the scale of this transform.
--- @param x number
--- @param y number
--- @return self transform
--- @usage
--- thisObject.transform:setScale(2, 2)
function Transform:setScale(x, y)
    self.scale.x = x or self.scale.x
    self.scale.y = y or self.scale.y

    return self
end

function Transform:translate(x, y, z)
    self.position.x = self.position.x + (x or 0)
    self.position.y = self.position.y + (y or 0)
    self.position.z = self.position.z + (z or 0)

    return self
end

return Transform