--- The index module of Micro2D.
--- @module core_index
--- @author Sharper Dev

local CoreIndex = {}
local InputSystem = require("micro2d.input.m2d_input_system")
local Canvas = require("micro2d.ui.m2d_ui_canvas")
local Image = require("micro2d.ui.m2d_ui_image")

local bottomCanvas
local bottomBackground

------
--- Called when the app starts.
function CoreIndex._start()
    Graphics.init()
    bottomCanvas = Canvas:new(BOTTOM_SCREEN)
    bottomBackground = Image:new({ imagePath = "romfs:/images/background_bottom.png" })
    bottomCanvas:addCanvasComponent(bottomBackground)
end

------
--- Called every frame.
function CoreIndex._loop()
    Screen.refresh()
    Screen.waitVblankStart()
    
    Screen.clear(TOP_SCREEN)
    Screen.clear(BOTTOM_SCREEN)
    
    bottomCanvas:draw()
    
    Screen.flip()
    
    if InputSystem.getKeyDown(KEY_HOME) or InputSystem.getKeyDown(KEY_POWER) then
        Graphics.term()
        System.exit()
    end
end

return CoreIndex