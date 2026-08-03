local Object2 = require("gameobject.m2d_gameobject"):new("2")
local Script2 = Object2:addComponent("Script", {})
local Input = require("input.m2d_input_system")
local Canvas = Object2:addComponent("Canvas", TOP_SCREEN)
local Image = Object2:addComponent("Image", "romfs:/assets/images/background_bottom.png")
local CanvasBottom = Object2:addComponent("Canvas", BOTTOM_SCREEN)
local Image2 = Object2:addComponent("Image", "romfs:/assets/images/background_bottom.png")
local Object1

function Script2:start()
    Object1 = Object2.findByName("1")
    
end

function Script2:update()
    -- Graphics.initBlend(TOP_SCREEN)
    -- local pos = Object2.transform:getPosition()
    -- local pos1 = Object1.transform:getPosition()
    -- Graphics.fillRect(pos.x, 50 + pos.x, pos.y, 50 + pos.y, Color.new(255,255,255))
    -- Graphics.fillRect(pos1.x, 100 + pos1.x, pos1.y, 100 + pos1.y, Color.new(255,255,0))
    -- Graphics.termBlend()
end
return Object2