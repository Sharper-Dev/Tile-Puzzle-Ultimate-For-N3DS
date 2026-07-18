local GameObject = {}
function GameObject:new()
    local this = setmetatable({}, GameObject)
    this.transform = require("components.transform.m2d_transform"):new()
    this.components = {}
    setmetatable(this, {__index = GameObject})
    return this
end

function GameObject:addComponent(component)
    table.insert(self.components, component)
end

function GameObject:destroy()
    for _, component in ipairs(self.components) do
        component:destroy()
    end
end

return GameObject