--- The UI transform.
--- @module ui_transform
--- @author Sharper Dev

local UITransform = {}
UITransform.__index = UITransform

function UITransform:new()
    local this = setmetatable({}, UITransform)
    this.position = { x = 0, y = 0, z = 0 }
    this.rotation = 0
    this.scale = { x = 1, y = 1 }
    return this
end

function UITransform:setPosition(x, y, z)
    self.position.x = x or self.position.x
    self.position.y = y or self.position.y
    self.position.z = z or self.position.z
    return self
end

function UITransform:getPosition()
    return self.position
end

function UITransform:setRotation(rotation)
    self.rotation = rotation or self.rotation
    return self
end

function UITransform:setScale(x, y)
    self.scale.x = x or self.scale.x
    self.scale.y = y or self.scale.y
    return self
end

return UITransform