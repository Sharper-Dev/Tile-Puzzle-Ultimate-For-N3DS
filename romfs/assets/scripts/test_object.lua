local Object = require("gameobject.m2d_gameobject"):new()
local Input = require("input.m2d_input_system")
local Script = Object:addComponent("Script", {})
local ScenesManager = require("scenes.m2d_scenes_manager")

function Script:start()
end

function Script:update()
    Graphics.initBlend(TOP_SCREEN)
    Graphics.fillRect(0,100,0,100,Color.new(255,255,255))
    Graphics.termBlend()
    if Input.getKeyDown(KEY_B) then
        ScenesManager.loadScene(2)
    end
end

return Object