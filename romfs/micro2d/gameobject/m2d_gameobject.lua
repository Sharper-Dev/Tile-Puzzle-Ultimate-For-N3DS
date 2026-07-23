
local GameObject = {}
local componentsList = {
    ["Script"] = "script.m2d_script",
    ["Canvas"] = "ui.m2d_canvas",
    ["Image"] = "ui.m2d_image"
}
function GameObject:new()
    local this = setmetatable({}, GameObject)
    this.transform = require("components.transform.m2d_transform"):new()
    this.components = {}
    setmetatable(this, {__index = GameObject})
    return this
end

function GameObject:addComponent(component)
    local comp = require(componentsList[component]):new()
    table.insert(self.components, comp)
end 

function GameObject:destroy()
    for _, component in ipairs(self.components) do
        component:destroy()
    end
end

return GameObject