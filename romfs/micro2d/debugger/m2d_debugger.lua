local Debugger = {}

local InputSystem = require("input.m2d_input_system")
local GameObject = require("gameobject.m2d_gameobject")
local Time = require("time.m2d_time")
local ScenesManager = require("scenes.m2d_scenes_manager")

local isEnabled = false
local hasSetup = false

local enableCode = { KEY_DUP, KEY_DUP,
    KEY_DDOWN, KEY_DDOWN,
    KEY_DLEFT, KEY_DRIGHT,
    KEY_DLEFT, KEY_DRIGHT,
    KEY_B, KEY_A, KEY_START }

local functionKey = KEY_L
local disableKey = KEY_B
local switchToTopKey = KEY_DUP
local switchToBottomKey = KEY_DDOWN
local switchObjectToNextKey = KEY_DRIGHT
local switchObjectToPrevKey = KEY_DLEFT
local quickStepKey = KEY_R
local currentIndex = 1
local currentScreen = BOTTOM_SCREEN
local currentObjectIndex = 1

local hintsObject
local canvasObject
local titleObject
local topScreenOffset = 40

local runtimeInfo
local runtimeInfoText

local consoleObject
local consoleText
local consoleMessages = {"-", "-", "-", "-"}

local runtimeUpdateDelay = 0.5
local runtimeUpdateTimer

local objectInfo
local objectInfoText

local objectToDebug

local function updateRuntimeInfo()
    local fps = math.floor(1 / Time.deltaTime)
    runtimeInfoText:setContent(string.format("Lua RAM Usage: %.2f MB\nFPS: %d\nDelta Time: %.3fs\nCurrent scene: %s",
        collectgarbage("count") / 1024,
        fps,
        Time.deltaTime,
        ScenesManager.getActiveScenes()[1].name))
end

local function updateObjectInfo()
    if objectToDebug then
        local name = objectToDebug.name
        local position = objectToDebug.transform.position
        local rotation = objectToDebug.transform.rotation
        local scale = objectToDebug.transform.scale
        objectInfoText:setContent(string.format(
            "Debugging:\n%s\nPosition: (%.1f, %.1f, %.1f)\nRotation: %d\nScale: (%.1f, %.1f)",
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
    local canvas = canvasObject:addComponent("Canvas", currentScreen)

    titleObject = GameObject.instantiate(GameObject:new("DEBUGGER_TITLE"))
    titleObject.transform:setPosition(90, 10, 101)
    titleObject.transform:setScale(2, 2)

    local backgroundObject = GameObject.instantiate(GameObject:new("DEBUGGER_BACKGROUND"))
    backgroundObject.transform:setPosition(160, 120, 100)
    backgroundObject.transform:setScale(2)
    
    local backgroundImage = backgroundObject:addComponent("Image", "romfs:/micro2d/assets/images/bg_bottom.png")
    backgroundImage:setCanvas(canvas)
    backgroundImage:setColor(0, 0, 0)

    local text = titleObject:addComponent("Text", "DEBUG MODE")
    text:setCanvas(canvas)
    text:setFont("default")

    objectInfo = GameObject.instantiate(GameObject:new("DEBUGGER_OBJECT_INFO"))
    objectInfo.transform:setPosition(5, 97, 101)
    objectInfo.transform:setScale(1, 1)

    objectInfoText = objectInfo:addComponent("Text", "")
    objectInfoText:setCanvas(canvas)
    objectInfoText:setFont("default")
    objectInfoText:setLineBreakDistance(13)

    runtimeInfo = GameObject.instantiate(GameObject:new("DEBUGGER_RUNTIME_INFO"))
    runtimeInfo.transform:setPosition(5, 40, 101)
    runtimeInfo.transform:setScale(1, 1)

    runtimeInfoText = runtimeInfo:addComponent("Text", "")
    runtimeInfoText:setCanvas(canvas)
    runtimeInfoText:setFont("default")
    runtimeInfoText:setLineBreakDistance(13)
    
    hintsObject = GameObject.instantiate(GameObject:new("DEBUGGER_HINTS"))
    hintsObject.transform:setPosition(205, 40, 101)
    
    local hintsText = hintsObject:addComponent("Text", "L + UP:\nTo top screen\nL + DOWN:\nTo bottom screen\nL + Right/Left:\nSwitch object\nR + Right/Left:\nQuick step\nL + B: Quit")
    hintsText:setLineBreakDistance(13)
    hintsText:setCanvas(canvas)
    hintsText:setFont("default")

    consoleObject = GameObject.instantiate(GameObject:new("DEBUGGER_CONSOLE"))
    consoleObject.transform:setPosition(5, 200, 101)
    
    consoleText = consoleObject:addComponent("Text", "")
    consoleText:setLineBreakDistance(12)
    consoleText:setCanvas(canvas)
    consoleText:setFont("default")
    Debugger.msg("Debugger initialized")
    updateRuntimeInfo()
    Debugger.debugObject(ScenesManager.getActiveScenes()[1].gameObjects[currentObjectIndex])
end
local function switchObject(isForward)
    if not isEnabled then return end
    local objectCount = #ScenesManager.getActiveScenes()[1].gameObjects
    if isForward then
        currentObjectIndex = (currentObjectIndex + 1) % objectCount
    else
        currentObjectIndex = (currentObjectIndex - 1) % objectCount
    end
    
    if currentObjectIndex < 1 then currentObjectIndex = objectCount end
        
    Debugger.debugObject(ScenesManager.getActiveScenes()[1].gameObjects[currentObjectIndex])
end
local function switchDebugScreen(screen)
    if screen == currentScreen then return end
    currentScreen = screen
    
    canvasObject.canvas:switchScreen(screen)
    local offset = screen == TOP_SCREEN and topScreenOffset or -topScreenOffset
    titleObject.transform:translate(offset)
    runtimeInfo.transform:translate(offset)
    objectInfo.transform:translate(offset)
    hintsObject.transform:translate(offset)
end

local function detectFunction()
    if not isEnabled then return end

	if InputSystem.getKey(functionKey) then
        if InputSystem.getKeyDown(switchToTopKey) then
            switchDebugScreen(TOP_SCREEN)
        elseif InputSystem.getKeyDown(switchToBottomKey) then
            switchDebugScreen(BOTTOM_SCREEN)
        end
        if InputSystem.getKeyDown(disableKey) then
            isEnabled = false
            canvasObject.canvas.enabled = false
        end
        if InputSystem.getKeyDown(switchObjectToNextKey) then
            switchObject(true)
        elseif InputSystem.getKeyDown(switchObjectToPrevKey) then
            switchObject(false)
        end
	end
end

local function detectCode()
    local rawInput = InputSystem.getRawInput() & 0x0FFF
    if rawInput == 0 or isEnabled then return end

    if currentIndex == #enableCode + 1 then
        if not hasSetup then
            setupDebugger()
            hasSetup = true
        else
            isEnabled = true
            canvasObject.canvas.enabled = true
        end
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

function Debugger.msg(msg)
    if not isEnabled then return end
    
	table.insert(consoleMessages, msg)
    if #consoleMessages > 4 then
        table.remove(consoleMessages, 1)
    end
    local content = ""
    for i = 1, #consoleMessages do
        content = content .. consoleMessages[i] .. "\n"
    end
    consoleText:setContent(content)
end

function Debugger.update()
    detectCode()
    detectFunction()
    if isEnabled then
        if objectToDebug and not InputSystem.getKey(functionKey) then
            local step = (InputSystem.getKey(quickStepKey)) and 10 or 1
            if InputSystem.getKeyDown(KEY_DUP) then
                objectToDebug.transform:translate(0, -step)
            end
            if InputSystem.getKeyDown(KEY_DDOWN) then
                objectToDebug.transform:translate(0, step)
            end
            if InputSystem.getKeyDown(KEY_DLEFT) then
                objectToDebug.transform:translate(-step, 0)
            end
            if InputSystem.getKeyDown(KEY_DRIGHT) then
                objectToDebug.transform:translate(step, 0)
            end
        end
        
        updateObjectInfo()
        
        if Timer.getTime(runtimeUpdateTimer) / 1000 >= runtimeUpdateDelay then
            updateRuntimeInfo()
            Timer.reset(runtimeUpdateTimer)
        end
    end
end
function Debugger.isEnabled()
	return isEnabled
end
function Debugger.debugObject(obj)
    objectToDebug = obj
end

return Debugger