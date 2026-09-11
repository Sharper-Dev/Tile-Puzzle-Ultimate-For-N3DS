local GameObject = require("gameobject.m2d_gameobject")

local thisObject = GameObject:new("board")

local Script = thisObject:addComponent("Script")
local Sprite = thisObject:addComponent("Sprite")

function Script.start()
    thisObject.transform:setPosition(160, 120, 2)
    Sprite:setSprite("romfs:/assets/sprites/board/board.png")
    Sprite:setScreen(BOTTOM_SCREEN)
end

return thisObject