local Object = require("gameobject.m2d_gameobject"):new("main")

local Input = require("input.m2d_input_system")
local Script = Object:addComponent("Script", {})

local Object2

function Script:start()
    Object2 = Object.get("2")
    Object.transform:setPosition(0, 100)
end

function Script:update()
    Graphics.initBlend(BOTTOM_SCREEN)
    local pos = Object.transform:getPosition()
    Graphics.fillRect(pos.x, 100 + pos.x, pos.y, 100 + pos.y, Color.new(255,255,255))
    Graphics.termBlend()
    if (Input.getKeyDown(KEY_A)) then
        Object.transform:setParent(Object2.transform)
    end
    if Input.getKeyDown(KEY_DRIGHT) then
        local position = Object.transform:getPosition()
        position.x = position.x + 3
        Object.transform:setPosition(position.x)
    end
end
return Object