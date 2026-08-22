local Debugger = {}
local InputSystem = require("input.m2d_input_system")
local GameObject = require("gameobject.m2d_gameobject")
local Time = require("time.m2d_time")

local isEnabled = false
local enableCode = { KEY_DUP, KEY_DUP,
    KEY_DDOWN, KEY_DDOWN,
    KEY_DLEFT, KEY_DRIGHT,
    KEY_DLEFT, KEY_DRIGHT,
    KEY_B, KEY_A, KEY_START}
local currentIndex = 1

local canvasObject
local titleObject

local runtimeInfo
local runtimeInfoText

local runtimeUpdateDelay = 0.5
local runtimeUpdateTimer

local objectInfo
local objectInfoText

local objectToDebug

local function updateRuntimeInfo()
    local fps = math.floor(1 / Time.deltaTime)
    runtimeInfoText:setContent(string.format("Lua RAM Usage: %.2f MB\nFPS: %d\nDelta Time: %.3fs", collectgarbage("count") / 1024, fps, Time.deltaTime))
end

local function updateObjectInfo()
    if objectToDebug then
        local name = objectToDebug.name
        local position = objectToDebug.transform:getPosition()
        local rotation = objectToDebug.transform.rotation
        local scale = objectToDebug.transform.scale
        objectInfoText:setContent(string.format(
            "Debugging: %s\nPosition: (%.1f, %.1f, %.1f)\nRotation: %d\nScale: (%.1f, %.1f)",
            name, position.x, position.y, position.z, rotation, scale.x, scale.y))
    else
        objectInfoText:setContent("Not debugging object")
    end
end

local function setupDebugger()
    isEnabled = true
    
    runtimeUpdateTimer = Timer.new()
    
    canvasObject = GameObject.instantiate(GameObject:new("DEBUGGER_CANVAS"))
    canvasObject.transform:setPosition(0, 0, 99)
    local canvas = canvasObject:addComponent("Canvas", BOTTOM_SCREEN)

    titleObject = GameObject.instantiate(GameObject:new("DEBUGGER_TITLE"))
    titleObject.transform:setPosition(90, 10, 99)
    titleObject.transform:setScale(2, 2)

    local backgroundObject = GameObject.instantiate(GameObject:new("DEBUGGER_BACKGROUND"))
    backgroundObject.transform:setPosition(160, 120, 98)

    local backgroundImage = backgroundObject:addComponent("Image", "romfs:/micro2d/assets/images/bg_bottom.png")
    backgroundImage:setCanvas(canvas)
    backgroundImage:setColor(0, 0, 0)

    local text = titleObject:addComponent("Text", "DEBUG MODE")
    text:setCanvas(canvas)
    text:setFont("default")

    objectInfo = GameObject.instantiate(GameObject:new("DEBUGGER_OBJECT_INFO"))
    objectInfo.transform:setPosition(5, 196, 99)
    objectInfo.transform:setScale(1, 1)

    objectInfoText = objectInfo:addComponent("Text", "")
    objectInfoText:setCanvas(canvas)
    objectInfoText:setFont("default")
    objectInfoText:setLineBreakDistance(13)

    runtimeInfo = GameObject.instantiate(GameObject:new("DEBUGGER_RUNTIME_INFO"))
    runtimeInfo.transform:setPosition(5, 40, 99)
    runtimeInfo.transform:setScale(1, 1)

    runtimeInfoText = runtimeInfo:addComponent("Text", "")
    runtimeInfoText:setCanvas(canvas)
    runtimeInfoText:setFont("default")
    runtimeInfoText:setLineBreakDistance(13)
    updateRuntimeInfo()
end

local function detectCode()
    local rawInput = InputSystem.getRawInput() & 0x0FFF
    if rawInput == 0 or isEnabled then return end
        
    if currentIndex == #enableCode + 1 then
        setupDebugger()
        currentIndex = 1
        return
    end
    
    if InputSystem.getKeyDown(enableCode[currentIndex]) then
        if rawInput == enableCode[currentIndex] then
            currentIndex = currentIndex + 1
        end
        return
    end
    
    if InputSystem.getKeyDown(rawInput) then
        currentIndex = 1
    end
end

function Debugger.update()
    detectCode()
    
    if isEnabled then
        if InputSystem.getKeyDown(KEY_DUP) then
            objectToDebug.transform:translate(0, -1, 0)
        end
        if InputSystem.getKeyDown(KEY_DDOWN) then
            objectToDebug.transform:translate(0, 1, 0)
        end
        if InputSystem.getKeyDown(KEY_DLEFT) then
            objectToDebug.transform:translate(-1, 0, 0)
        end
        if InputSystem.getKeyDown(KEY_DRIGHT) then
            objectToDebug.transform:translate(1, 0, 0)
        end
        
        updateObjectInfo()
        
        if Timer.getTime(runtimeUpdateTimer) / 1000 >= runtimeUpdateDelay then
            updateRuntimeInfo()
            Timer.reset(runtimeUpdateTimer)
        end
    end
end

function Debugger.debugObject(obj)
    objectToDebug = obj
end

return Debugger
