--- The GameObject transform.
--- @module component_transform
--- @author Sharper Dev

local Transform = {}
Transform.__index = Transform

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

local function worldToLocal(parent, child)
    return {
        x = child.position.x - parent.position.x,
        y = child.position.y - parent.position.y,
        z = child.position.z - parent.position.z,
    }
end

local function localToWorld(parent, child)
    return {
        x = child.localPosition.x + parent.position.x,
        y = child.localPosition.y + parent.position.y,
        z = child.localPosition.z + parent.position.z,
    }
end

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

function Transform:getPosition()
    if self.parent then
        return localToWorld(self.parent, self)
    end
    
    return self.position
end

function Transform:setRotation(rotation)
    self.rotation = rotation or self.rotation
    
    return self
end

function Transform:setScale(x, y)
    self.scale.x = x or self.scale.x
    self.scale.y = y or self.scale.y
    return self
end

return Transform