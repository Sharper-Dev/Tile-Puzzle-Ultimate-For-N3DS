--- The runtime module of Micro2D.
--- @module core_runtime
--- @author Sharper Dev

local CoreRuntime = {}
local InputSystem = require("input.m2d_input_system")
local Canvas = require("ui.m2d_ui_canvas")
local Image = require("ui.m2d_ui_image")

local bottomCanvas
local bottomBackground

CoreRuntime.behaviours = {}

------
--- Called when the app starts.
function CoreRuntime._start()
    Graphics.init()
    dofile("romfs:/assets/scripts/behaviour_test.lua")
    for _, behaviour in ipairs(CoreRuntime.behaviours) do
        behaviour:start()
    end
    -- bottomCanvas = Canvas:new(BOTTOM_SCREEN)
    -- bottomBackground = Image:new({ imagePath = "romfs:/assets/images/background_bottom.png" })
    -- bottomCanvas:addCanvasComponent(bottomBackground)
end

------
--- Called every frame.
function CoreRuntime._loop()
    Screen.refresh()
    Screen.waitVblankStart()
    
    Screen.clear(TOP_SCREEN)
    Screen.clear(BOTTOM_SCREEN)
    
    for _, behaviour in ipairs(CoreRuntime.behaviours) do
        behaviour:update()
    end
    --bottomCanvas:draw()
    
    Screen.flip()
    
    if InputSystem.getKeyDown(KEY_HOME) or InputSystem.getKeyDown(KEY_POWER) then
        Graphics.term()
        System.exit()
    end
end

return CoreRuntime