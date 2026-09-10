local GameObject = require("gameobject.m2d_gameobject")
local Time = require("time.m2d_time")

local thisObject = GameObject:new("top_title")
local Script = thisObject:addComponent("Script")
local Sprite = thisObject:addComponent("Sprite")

local startPosition = { x = 200, y = 120 }
local amplitude = 5
local frequency = 2
local counter = 0
local counterLimit = 2 * math.pi

function Script:start()
    thisObject.transform:setPosition(startPosition.x, startPosition.y, 1)
    Sprite:setSprite("romfs:/assets/sprites/title/title.png")
    Sprite:setScreen(TOP_SCREEN)
end

function Script:update()
    counter = counter + Time.deltaTime
    local nextPosition = { x = startPosition.x, y = startPosition.y + amplitude * math.sin(frequency * counter) }
    thisObject.transform:setPosition(nextPosition.x, nextPosition.y)
    if counter >= counterLimit then
        counter = 0
    end
end

return thisObject