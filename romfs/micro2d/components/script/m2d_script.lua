--- The base script for all objects.
--- It contains the life cycle functions.
--- @module components_script
--- @author Sharper Dev

local Script = {}
Script.__index = Script
------
--- The constructor for the script.
function Script:new()
    self = setmetatable({}, Script)
    self.enabled = true
    return self
end

function Script:destroy()
    self.enabled = nil
    self = nil
end
------
--- Virtual method called when the object is instantiated.
--
--
--- You can override this method to perform initialization.
--- @usage
--- local GameObject = require("gameobject.m2d_gameobject")
---
--- local thisObject = GameObject:new("Name here")
--- local script = thisObject:addComponent("Script", {})
--- 
--- function script:start()
---     -- Start code here
--- end
Script.start = function() end

--- Virtual method called every game's frame.
--
-- 
--- You can override this method to update the object's state.
--- @usage
--- local GameObject = require("gameobject.m2d_gameobject")
---
--- local thisObject = GameObject:new("Name here")
--- local script = thisObject:addComponent("Script", {})
--- 
--- function script:update()
---     -- Update code here
--- end
Script.update = function() end

return Script