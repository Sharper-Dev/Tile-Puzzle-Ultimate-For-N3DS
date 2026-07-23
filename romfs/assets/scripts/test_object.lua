local Object = require("gameobject.m2d_gameobject"):new()
local Script = require("components.script.m2d_script"):new()
Object:addComponent(Script)

local Input = require("input.m2d_input_system")

function Script:start()
end

function Script:update()
    -- bottomCanvas:draw()
    if Input.getKeyDown(KEY_B) then
        --ScenesManager.loadScene(2)
    end
end

return Object