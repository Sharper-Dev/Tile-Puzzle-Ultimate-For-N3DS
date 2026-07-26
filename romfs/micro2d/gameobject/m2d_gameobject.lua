
local GameObject = {}
local componentsList = {
    ["Script"] = "components.script.m2d_script",
    --["Canvas"] = "components.ui.m2d_canvas",
    --["Image"] = "components.ui.m2d_image"
}
function GameObject:new()
    local this = setmetatable({}, GameObject)
    this.transform = require("components.transform.m2d_transform"):new()
    this.components = {}
    setmetatable(this, {__index = GameObject})
    return this
end

function GameObject:addComponent(component, params)
    local comp = require(componentsList[component]):new(params)
    table.insert(self.components, comp)
    return comp
end 

function GameObject:destroy()
    for _, component in ipairs(self.components) do
        component:destroy()
    end
end

return GameObject