--- The base class for all objects.
--- It contains the life cycle functions.
--- @module gameobject_behaviour
--- @author Sharper Dev

local Behaviour = {}
------
--- The constructor for the object behaviour.
--- It creates a new behaviour object and adds it to the runtime.
function Behaviour:new()
    local this = setmetatable({}, Behaviour)
    setmetatable(this, {__index = Behaviour})
    return this
end
------
--- Virtual method called when the object is instantiated.
--
--
--- You can override this method to perform initialization.
--- @usage
--- local Behaviour = require("behaviour.m2d_object_behaviour")
--- local MyObject = Behaviour:new()
--- MyObject.__index = MyObject
--- 
--- function MyObject:start()
---     -- Do something when the object is instantiated
--- end
Behaviour.start = function() end

--- Virtual method called every game frame.
--
-- 
--- You can override this method to update the object's state.
--- @usage
--- local Behaviour = require("behaviour.m2d_object_behaviour")
--- local MyObject = Behaviour:new()
--- MyObject.__index = MyObject
--- 
--- function MyObject:update()
---     -- Do something every frame.
--- end
Behaviour.update = function() end

return Behaviour