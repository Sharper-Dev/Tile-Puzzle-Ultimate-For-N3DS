local SHCDebugger = {}

local InputSystem = require("lpp_input_system")
local currentComponent

local isDebugging = false
local value = 0.05

function SHCDebugger.startDebug(component)
    currentComponent = component
    isDebugging = true
end

function SHCDebugger.getDebugContent()
    if not isDebugging then return "" end
    local content = "(" ..
    currentComponent.transform.position.x .. ", " .. currentComponent.transform.position.y .. ", " .. currentComponent.transform.position.z ..")\n"
    .. "(" .. currentComponent.transform.scale.x .. ", " .. currentComponent.transform.scale.y .. ")"
    return content
end

function SHCDebugger.update()
    if not isDebugging then return end
    if InputSystem.getKeyDown(KEY_DUP) then
        currentComponent.transform:setPosition(currentComponent.transform.position.x,
            currentComponent.transform.position.y - 1)
    end
    if InputSystem.getKeyDown(KEY_DDOWN) then
        currentComponent.transform:setPosition(currentComponent.transform.position.x,
            currentComponent.transform.position.y + 1)
    end
    if InputSystem.getKeyDown(KEY_DLEFT) then
        currentComponent.transform:setPosition(currentComponent.transform.position.x - 1,
            currentComponent.transform.position.y)
    end
    if InputSystem.getKeyDown(KEY_DRIGHT) then
        currentComponent.transform:setPosition(currentComponent.transform.position.x + 1,
            currentComponent.transform.position.y)
    end
    if InputSystem.getKeyDown(KEY_B) then
        currentComponent.transform:setScale(currentComponent.transform.scale.x - value,
            currentComponent.transform.scale.y - value)
    end
    if InputSystem.getKeyDown(KEY_A) then
        currentComponent.transform:setScale(currentComponent.transform.scale.x + value,
            currentComponent.transform.scale.y + value)
    end

end

return SHCDebugger