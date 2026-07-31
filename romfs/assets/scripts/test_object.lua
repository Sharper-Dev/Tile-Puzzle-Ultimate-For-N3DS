local Object = require("gameobject.m2d_gameobject"):new("1")

local Input = require("input.m2d_input_system")
local Script = Object:addComponent("Script", {})

local Object2
function Script:start()
    Object2 = Object.findByName("2")
    Object.transform:setPosition(0, 100)
end

function Script:update()
    if Input.getKeyDown(KEY_DRIGHT) then
        local previousPosition = Object2.transform:getPosition().x
        previousPosition = previousPosition + 3
        Object2.transform:setPosition(previousPosition)
    end
    if Input.getKeyDown(KEY_DLEFT) then
        local previousPosition = Object2.transform:getPosition().x
        previousPosition = previousPosition - 3
        Object2.transform:setPosition(previousPosition)
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
    if Input.getKeyDown(KEY_B) then
        Object.transform:setParent(nil)
    end
    Screen.debugPrint(100, 2, "DEBUG MODE", Color.new(255, 255, 255), BOTTOM_SCREEN)
    local x = Object.transform:getPosition().x
    local y = Object.transform:getPosition().y
    local z = Object.transform:getPosition().z
    Screen.debugPrint(2, 20, string.format("OBJ1: %s", Object.transform:getHierarchyString()), Color.new(255,255,255), BOTTOM_SCREEN)
    Screen.debugPrint(2, 40, string.format("Position: %s, %s, %s", x, y, z), Color.new(255, 255, 255), BOTTOM_SCREEN)
    x = Object.transform.localPosition.x
    y = Object.transform.localPosition.y
    z = Object.transform.localPosition.z
    Screen.debugPrint(2, 60, string.format("Local Position: %s, %s, %s", x, y, z), Color.new(255, 255, 255),
        BOTTOM_SCREEN)
    x, y, z = Object.transform:getFinalPosition().x, Object.transform:getFinalPosition().y, Object.transform:getFinalPosition().z
    Screen.debugPrint(2, 80, string.format("Final Position: %s, %s, %s", x, y, z), Color.new(255, 255, 255), BOTTOM_SCREEN)
    
end
return Object