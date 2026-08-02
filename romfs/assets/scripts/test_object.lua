local Object = require("gameobject.m2d_gameobject"):new("1")

local Input = require("input.m2d_input_system")
local ScenesManager = require("scenes.m2d_scenes_manager")
local Script = Object:addComponent("Script", {})
local currentScene
local Object2

function Script:start()
    currentScene = ScenesManager.getActiveScenes()[1]
    Object2 = Object.findByName("2")
    Object.transform:setPosition(50, 100, nil)
    local obj1 = Object.instantiate("romfs:/assets/scripts/object3.lua")
    local obj2 = Object.instantiate("romfs:/assets/scripts/object3.lua")
    obj1.transform:setParent(Object.transform)
    obj2.transform:setParent(obj1.transform)
end

function Script:update()
    if Input.getKeyDown(KEY_DRIGHT) then
        local previousPosition = Object.transform:getPosition().x
        previousPosition = previousPosition + 3
        Object.transform:setPosition(previousPosition)
    end
    if Input.getKeyDown(KEY_DLEFT) then
        local previousPosition = Object.transform:getPosition().x
        previousPosition = previousPosition - 3
        Object.transform:setPosition(previousPosition)
    end

    if Input.getKeyDown(KEY_DUP) then
        local previousPosition = Object2.transform:getPosition().y
        previousPosition = previousPosition - 3
        Object2.transform:setPosition(nil, previousPosition)
    end
    if Input.getKeyDown(KEY_DDOWN) then
        local previousPosition = Object2.transform:getPosition().y
        previousPosition = previousPosition + 3
        Object2.transform:setPosition(nil, previousPosition)
    end
    
    if Input.getKeyDown(KEY_A) then
        Object.transform:setParent(Object2.transform)
    end
    if Input.getKeyDown(KEY_X) then
        local previousPosition = Object.transform:getPosition().x
        previousPosition = previousPosition + 3
        Object.transform:setPosition(previousPosition)
    end
    
    Screen.debugPrint(100, 2, "DEBUG MODE", Color.new(255, 255, 255), BOTTOM_SCREEN)
    Screen.debugPrint(2, 20, string.format("Lua RAM: %.2f MB", collectgarbage("count") / 1024), Color.new(255, 255, 255), BOTTOM_SCREEN)
    
    if Input.getKeyDown(KEY_B) then
        ScenesManager.loadScene(2)
    end
end
return Object