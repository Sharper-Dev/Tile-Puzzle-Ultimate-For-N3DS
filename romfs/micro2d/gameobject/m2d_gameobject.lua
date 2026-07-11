local GameObject = {}
function GameObject:new()
    local this = setmetatable({}, GameObject)
    this.behaviour = require("gameobject.m2d_gameobject_behaviour"):new()
    setmetatable(this, {__index = GameObject})
    
    return this
end

return GameObject