--- The runtime module of Micro2D.
--- @module core_runtime
--- @author Sharper Dev

local CoreRuntime = {}
local InputSystem = require("input.m2d_input_system")
local ScenesManager = require("scenes.m2d_scenes_manager")

------
--- Called when the app starts.
function CoreRuntime._start()
    Graphics.init()
    ScenesManager.loadScene(1)
end

------
--- Called every frame.
function CoreRuntime._loop()
    Screen.refresh()
    Screen.waitVblankStart()
    
    Screen.clear(TOP_SCREEN)
    Screen.clear(BOTTOM_SCREEN)
    ScenesManager.getCurrentScene():update()
    Screen.flip()
    
    if InputSystem.getKeyDown(KEY_HOME) or InputSystem.getKeyDown(KEY_POWER) then
        Graphics.term()
        System.exit()
    end
end

return CoreRuntime