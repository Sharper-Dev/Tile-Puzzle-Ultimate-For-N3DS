local Object = require("gameobject.m2d_gameobject"):new()
local Script = require("components.script.m2d_script"):new()
local Script2 = require("components.script.m2d_script"):new()
Object:addComponent(Script)
Object:addComponent(Script2)

local Canvas = require("components.ui.m2d_canvas")
local Image = require("components.ui.m2d_image")

local topCanvas
local bottomCanvas
local bottomBackground

function Script:start()
    bottomCanvas = Canvas:new(BOTTOM_SCREEN)
    bottomBackground = Image:new({ imagePath = "romfs:/assets/images/background_bottom.png", gameObject = Object })
    bottomCanvas:addCanvasComponent(bottomBackground)
end

function Script:update()
    bottomCanvas:draw()
end

function Script2:start()
    topCanvas = Canvas:new(TOP_SCREEN)
    topCanvas:addCanvasComponent(bottomBackground)
end

function Script2:update()
    topCanvas:draw()
end

return Object