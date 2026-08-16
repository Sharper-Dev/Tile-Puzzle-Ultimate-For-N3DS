local Debugger = {}
local InputSystem = require("input.m2d_input_system")
local GameObject = require("gameobject.m2d_gameobject")
local FontsManager = require("fonts.m2d_fonts_manager")
local Time = require("time.m2d_time")

local isEnabled = false
local enableKey = KEY_START

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
            "Debugging: %s\nPosition: (%d, %d, %d)\nRotation: %d\nScale: (%d, %d)",
            name, position.x, position.y, position.z, rotation, scale.x, scale.y))
    else
        objectInfoText:setContent("Not debugging object")
    end
end

local function setupDebugger()
    isEnabled = true
    FontsManager.loadFont("dogica", "romfs:/assets/fonts/dogica_8px")
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
    text:setFont("dogica")

    objectInfo = GameObject.instantiate(GameObject:new("DEBUGGER_OBJECT_INFO"))
    objectInfo.transform:setPosition(5, 196, 99)
    objectInfo.transform:setScale(1, 1)

    objectInfoText = objectInfo:addComponent("Text", "")
    objectInfoText:setCanvas(canvas)
    objectInfoText:setFont("dogica")
    objectInfoText:setLineBreakDistance(13)

    runtimeInfo = GameObject.instantiate(GameObject:new("DEBUGGER_RUNTIME_INFO"))
    runtimeInfo.transform:setPosition(5, 40, 99)
    runtimeInfo.transform:setScale(1, 1)

    runtimeInfoText = runtimeInfo:addComponent("Text", "")
    runtimeInfoText:setCanvas(canvas)
    runtimeInfoText:setFont("dogica")
    runtimeInfoText:setLineBreakDistance(13)
    updateRuntimeInfo()
    
    Debugger.debugObject(runtimeInfo)
end


function Debugger.update()
    if InputSystem.getKeyDown(enableKey) and not isEnabled then
        setupDebugger()
    end
    
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
