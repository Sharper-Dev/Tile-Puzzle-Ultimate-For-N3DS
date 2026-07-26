local Object = require("gameobject.m2d_gameobject"):new()
local Input = require("input.m2d_input_system")
local Script = Object:addComponent("Script", {})

function Script:start()
end

function Script:update()
    if Input.getKeyDown(KEY_B) then
        
    end
end

return Object