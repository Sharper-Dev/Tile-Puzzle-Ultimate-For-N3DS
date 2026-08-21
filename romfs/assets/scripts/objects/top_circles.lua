local GameObject = require("gameobject.m2d_gameobject")
local Debugger = require("debugger.m2d_debugger")
local Time = require("time.m2d_time")
local MathE = require("extender.math.m2d_math")

local thisObject = GameObject:new("top_circles")
local Script = thisObject:addComponent("Script", {})
local Sprite = thisObject:addComponent("Sprite", "romfs:/assets/sprites/background/circles.png")

local startPos = { x = 216, y = 137 }
local finalPos = { x = 190, y = 86 }

local speed = 0.5
local counter = 0

function Script:start()
    thisObject.transform:setPosition(startPos.x, startPos.y, 1)
    Sprite:setScreen(TOP_SCREEN)
    Debugger.debugObject(thisObject)
end

function Script:update()
    counter = counter + Time.deltaTime * speed
    
    local x = MathE.lerp(startPos.x, finalPos.x, math.min(counter, 1.0))
    local y = MathE.lerp(startPos.y, finalPos.y, math.min(counter, 1.0))
    
    thisObject.transform:setPosition(x, y)
    if counter >= 1.0 then
        counter = 0
    end
end
return thisObject