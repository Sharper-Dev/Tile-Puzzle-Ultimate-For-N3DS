local Object = require("gameobject.m2d_gameobject"):new()
local Script = require("components.script.m2d_script"):new()
Object:addComponent(Script)

local Canvas = require("components.ui.m2d_canvas")
local Image = require("components.ui.m2d_image")
local Input = require("input.m2d_input_system")
local ScenesManager = require("scenes.m2d_scenes_manager")

local topCanvas
local bottomBackground

function Script:start()
    -- topCanvas = Canvas:new(TOP_SCREEN)
    -- bottomBackground = Image:new({ imagePath = "romfs:/assets/images/background_bottom.png", gameObject = Object })
    -- topCanvas:addCanvasComponent(bottomBackground)
end

function Script:update()
    Graphics.initBlend(TOP_SCREEN)
    Graphics.fillRect(10, 100, 10, 100, Color.new(0, 0, 255))
    Graphics.termBlend()
    -- topCanvas:draw()
    if Input.getKeyDown(KEY_B) then
        ScenesManager.loadScene(1)
    end
end

return Object