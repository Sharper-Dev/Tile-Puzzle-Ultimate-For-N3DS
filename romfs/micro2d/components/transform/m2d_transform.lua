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
        self.position.x = self.parent.position.x + self.localPosition.x
        self.position.y = self.parent.position.y + self.localPosition.y
        self.position.z = self.parent.position.z + self.localPosition.z
    end
    self.parent = transform
    if transform then
        transform.children[tostring(self)] = self
        self.localPosition.x = self.position.x - transform.position.x
        self.localPosition.y = self.position.y - transform.position.y
        self.localPosition.z = self.position.z - transform.position.z
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
function Transform:getFinalPosition()
	local returnTable = {}
	if self.parent then
		returnTable.x = self.localPosition.x + self.parent.position.x
		returnTable.y = self.localPosition.y + self.parent.position.y
		returnTable.z = self.localPosition.z + self.parent.position.z
	else
		returnTable.x = self.position.x
		returnTable.y = self.position.y
		returnTable.z = self.position.z
	end
	return returnTable
end
function Transform:getPosition()
    if self.parent then
        local returnTable = {}
        returnTable.x = self.localPosition.x
        returnTable.y = self.localPosition.y
        returnTable.z = self.localPosition.z
        return returnTable
    else
        return self.position
    end
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