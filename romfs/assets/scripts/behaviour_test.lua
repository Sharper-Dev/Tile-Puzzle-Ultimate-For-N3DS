local Behaviour = require("behaviour.m2d_object_behaviour")
local BehaviourTest = Behaviour:new()
BehaviourTest.__index = BehaviourTest
local Canvas = require("ui.m2d_ui_canvas")
local Image = require("ui.m2d_ui_image")

local bottomCanvas
local bottomBackground

function BehaviourTest:start()
    error("False error: The object behaviour start has been called.")
    bottomCanvas = Canvas:new(BOTTOM_SCREEN)
    bottomBackground = Image:new({ imagePath = "romfs:/assets/images/background_bottom.png" })
    bottomCanvas:addCanvasComponent(bottomBackground)
end

function BehaviourTest:update()
    bottomCanvas:draw()
end