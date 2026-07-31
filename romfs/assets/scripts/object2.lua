local Object2 = require("gameobject.m2d_gameobject"):new("2")
local Script2 = Object2:addComponent("Script", {})

local Object1

function Script2:start()
    Object1 = Object2.findByName("1")
end

function Script2:update()
    Graphics.initBlend(TOP_SCREEN)
    local pos = Object2.transform:getFinalPosition()
    local pos1 = Object1.transform:getFinalPosition()
    Graphics.fillRect(pos.x, 50 + pos.x, pos.y, 50 + pos.y, Color.new(255,255,255))
    Graphics.fillRect(pos1.x, 100 + pos1.x, pos1.y, 100 + pos1.y, Color.new(255,255,0))
    Graphics.termBlend()
end
return Object2