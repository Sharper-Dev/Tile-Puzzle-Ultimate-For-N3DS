local Behaviour = {}
local Runtime = require("core.m2d_core_runtime")

function Behaviour:new()
    local this = setmetatable({}, Behaviour)
    table.insert(Runtime.behaviours, this)
    return this
end

function Behaviour:start()
	
end

function Behaviour:update()
    
end

return Behaviour