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
    this.parent = nil
    this.children = {}
    return this
end

function Transform:getHierarchyString()
    local children = {}
    for _, child in pairs(self.children) do
        table.insert(children, child.gameObject.name)
    end
    local parentName = "None"
    if self.parent then
        parentName = self.parent.gameObject.name
    end

    return string.format("Parent: %s, Children: %s", parentName, table.concat(children, ", "))
end

function Transform:setParent(transform)
    if self.parent then
        self.parent.children[tostring(self)] = nil
    end
    self.parent = transform
    if transform then
        transform.children[tostring(self)] = self
    end
    return self
end

function Transform:setPosition(x, y, z)
    self.position.x = x or self.position.x
    self.position.y = y or self.position.y
    self.position.z = z or self.position.z
    if self.parent then
        self.localPosition.x = self.position.x - self.parent.position.x
        self.localPosition.y = self.position.y - self.parent.position.y
        self.localPosition.z = self.position.z - self.parent.position.z
    end
    for _, child in ipairs(self.children) do
        child:setPosition()
    end
    return self
end

function Transform:getPosition()
    if self.parent then
        return { x = self.position.x + self.parent.position.x, y = self.position.y + self.parent.position.y, z = self.position.z + self.parent.position.z }
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