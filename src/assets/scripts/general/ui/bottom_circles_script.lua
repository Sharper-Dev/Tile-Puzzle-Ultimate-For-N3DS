local Script = {}
local Time = require("time.m2d_time")
local MathE = require("extender.math.m2d_math")

local startPos = { x = 216, y = 137 }
local finalPos = { x = 190, y = 86 }

local speed = 0.5
local counter = 0

function Script:start()
    self.transform:setPosition(startPos.x, startPos.y, 1)
    local Sprite = self:getComponent("Sprite")

    Sprite:setSprite("romfs:/assets/sprites/background/circles.png")
    Sprite:setScreen(BOTTOM_SCREEN)
    Sprite:setColor(254, 245, 213)
end

function Script:update()
    counter = counter + Time.deltaTime * speed

    local x = MathE.lerp(startPos.x, finalPos.x, math.min(counter, 1.0))
    local y = MathE.lerp(startPos.y, finalPos.y, math.min(counter, 1.0))

    self.transform:setPosition(x, y)
    if counter >= 1.0 then
        counter = 0
    end
end

return Script