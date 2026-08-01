--- The GameObject transform.
--- @module components_transform
--- @author Sharper Dev

local Transform = {}
Transform.__index = Transform

--- Local functions.
--- @section local_functions

--- Converts a world position to a local position.
--- @param parent transform
--- @param child transform
--- @return table {x, y, z}
local function worldToLocal(parent, child)
    return {
        x = child.position.x - parent.position.x,
        y = child.position.y - parent.position.y,
        z = child.position.z - parent.position.z,
    }
end

--- Converts a local position to a world position.
--- @param parent transform
--- @param child transform
--- @return table {x, y, z}
local function localToWorld(parent, child)
    return {
        x = child.localPosition.x + parent.position.x,
        y = child.localPosition.y + parent.position.y,
        z = child.localPosition.z + parent.position.z,
    }
end
--- Functions
--- @section functions

--- The transform constructor.
--- @param gameObject m2d_gameobject GameObject this transform belongs to.
--- @return self transform
function Transform:new(gameObject)
    local this = setmetatable({}, Transform)
    this.gameObject = gameObject
    this.position = { x = 0, y = 0, z = 0 }
    this.localPosition = { x = 0, y = 0, z = 0 }
    this.rotation = 0
    this.scale = { x = 1, y = 1 }
    this.localScale = { x = 1, y = 1 }
    this.parent = nil
    this.children = {}
    return this
end

--- Sets the parent of this transform.
--
--- If the paramter is nil, the parent will be removed.
--- @param transform m2d_transform The transform to set as the parent.
--- @return self transform
function Transform:setParent(transform)
    if self.parent then
        self.parent.children[tostring(self)] = nil
        self.position = localToWorld(self.parent, self)
    end
    self.parent = transform
    if transform then
        transform.children[tostring(self)] = self
        self.localPosition = worldToLocal(transform, self)
    end
    
    return self
end

--- Sets the position of this transform.
--- @param x number
--- @param y number
--- @param z number
--- @return self transform
function Transform:setPosition(x, y, z)
    if self.parent then
        self.localPosition.x = x or self.localPosition.x
        self.localPosition.y = y or self.localPosition.y
        self.localPosition.z = z or self.localPosition.z
    else
        self.position.x = x or self.position.x
        self.position.y = y or self.position.y
        self.position.z = z or self.position.z
    end

    return self
end

--- Returns the position of this transform.
--- @return table {x, y, z}
function Transform:getPosition()
    if self.parent then
        return localToWorld(self.parent, self)
    end

    return self.position
end

--- Sets the rotation of this transform.
--- @param rotation number
--- @return self transform
function Transform:setRotation(rotation)
    self.rotation = rotation or self.rotation
    
    return self
end

--- Sets the scale of this transform.
--- @param x number
--- @param y number
--- @return self transform
function Transform:setScale(x, y)
    self.scale.x = x or self.scale.x
    self.scale.y = y or self.scale.y
    return self
end

return Transform