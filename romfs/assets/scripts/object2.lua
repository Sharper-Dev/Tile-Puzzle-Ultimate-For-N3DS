local Object2 = require("gameobject.m2d_gameobject"):new("2")
local Script2 = Object2:addComponent("Script", {})

function Script2:update()
    Graphics.initBlend(TOP_SCREEN)
    local pos = Object2.transform:getPosition()
    Graphics.fillRect(pos.x, 100 + pos.x, pos.y, 100 + pos.y, Color.new(255,255,255))
    Graphics.termBlend()
end
return Object2