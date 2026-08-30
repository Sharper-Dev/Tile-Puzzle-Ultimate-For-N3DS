local Debugger = {}

local InputSystem = require("input.m2d_input_system")
local Time = require("time.m2d_time")
local ScenesManager = require("scenes.m2d_scenes_manager")

local Enabler = require("debugger.m2d_debugger_enabler")
local DebuggerUI = require("debugger.m2d_debugger_ui")

local isEnabled = false

local functionKey = KEY_L
local disableKey = KEY_B
local switchToTopKey = KEY_DUP
local switchToBottomKey = KEY_DDOWN
local switchObjectToNextKey = KEY_DRIGHT
local switchObjectToPrevKey = KEY_DLEFT
local quickStepKey = KEY_R
local currentObjectIndex = 1

local consoleMessages = {"-", "-", "-", "-"}

local runtimeUpdateDelay = 0.5
local runtimeUpdateTimer

local objectToDebug

local function updateRuntimeInfo()
    local fps = math.floor(1 / Time.deltaTime)
    DebuggerUI.texts["DEBUGGER_RUNTIME_INFO"]:setContent(string.format("Lua RAM Usage: %.2f MB\nFPS: %d\nDelta Time: %.3fs\nCurrent scene: %s",
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

        DebuggerUI.texts["DEBUGGER_OBJECT_INFO"]:setContent(string.format(
            "Debugging:\n%s\nPosition: (%.1f, %.1f, %.1f)\nRotation: %d\nScale: (%.1f, %.1f)",
            name, position.x, position.y, position.z, rotation, scale.x, scale.y))
    else
        DebuggerUI.texts["DEBUGGER_OBJECT_INFO"]:setContent("Not debugging object")
    end
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


local function detectFunction()
    if not isEnabled then return end

	if InputSystem.getKey(functionKey) then
        if InputSystem.getKeyDown(switchToTopKey) then
            DebuggerUI.switchDebugScreen(TOP_SCREEN)
        elseif InputSystem.getKeyDown(switchToBottomKey) then
            DebuggerUI.switchDebugScreen(BOTTOM_SCREEN)
        end
        if InputSystem.getKeyDown(disableKey) then
            isEnabled = false
            DebuggerUI.objects["DEBUGGER_CANVAS"].enabled = false
        end
        if InputSystem.getKeyDown(switchObjectToNextKey) then
            switchObject(true)
        elseif InputSystem.getKeyDown(switchObjectToPrevKey) then
            switchObject(false)
        end
	end
end

function Debugger.setupDebugger()
    runtimeUpdateTimer = Timer.new()
    isEnabled = true
    DebuggerUI.createUI()
    updateRuntimeInfo()
    Debugger.debugObject(ScenesManager.getActiveScenes()[1].gameObjects[currentObjectIndex])
    Debugger.msg("Debugger initialized")
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

    DebuggerUI.texts["DEBUGGER_CONSOLE"]:setContent(content)
end

function Debugger.update()
    Enabler.detectCode()
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

function Debugger.setEnable(value)
    isEnabled = value
end

function Debugger.debugObject(obj)
    objectToDebug = obj
end

return Debugger