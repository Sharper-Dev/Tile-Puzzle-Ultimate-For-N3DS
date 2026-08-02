--- The base class for all objects.
--- It contains the life cycle functions.
--- @module components_script
--- @author Sharper Dev

local Script = {}
Script.__index = Script
------
--- The constructor for the object behaviour.
--- It creates a new behaviour object and adds it to the runtime.
function Script:new()
    self = setmetatable({}, Script)
    self.enabled = true
    return self
end

function Script:destroy()
	self = nil
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
Script.start = function() end

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
Script.update = function() end

return Script