local GameObject = require("gameobject.m2d_gameobject")
local Input = require("input.m2d_input_system")
local Renderer = require("renderer.m2d_renderer")

local thisObject = GameObject:new("sprite")
local Script = thisObject:addComponent("Script", {})
local Sprite = thisObject:addComponent("Sprite", "romfs:/assets/images/background_bottom.png")

function Script:start()
    Sprite:setScreen(BOTTOM_SCREEN)
    thisObject.transform:setPosition(nil, nil, 0)
end

function Script:update()
    if Input.getKeyDown(KEY_A) then
        Sprite:setScreen(BOTTOM_SCREEN)
    end
    
    if Input.getKeyDown(KEY_B) then
        Sprite:setScreen(TOP_SCREEN)
    end
    
    if Input.getKeyDown(KEY_DUP) then
        thisObject.transform:setPosition(nil, nil, 3)
    end
    if Input.getKeyDown(KEY_DDOWN) then
        thisObject.transform:setPosition(nil, nil, 0)
    end
end

return thisObject