--- Debugger module for the Micro2D engine.
--- @module debugger
--- @author Sharper Dev

local Debugger = {}

local Time = require("time.m2d_time")
local ScenesManager = require("scenes.m2d_scenes_manager")
local Enabler = require("debugger.m2d_debugger_enabler")
local DebuggerUI = require("debugger.m2d_debugger_ui")
local Functions = require("debugger.m2d_debugger_functions")

local isEnabled = false

local consoleMessages = {"-", "-", "-", "-"}

local runtimeUpdateDelay = 0.5
local runtimeUpdateTimer

local objectToDebug

Debugger.currentObjectIndex = 1

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

function Debugger.setupDebugger()
    runtimeUpdateTimer = Timer.new()
    isEnabled = true
    DebuggerUI.createUI()
    updateRuntimeInfo()
    Debugger.debugObject(ScenesManager.getActiveScenes()[1].gameObjects[Debugger.currentObjectIndex])
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
    Functions.detectFunction()
    if isEnabled then
        Functions.detectMove()
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

function Debugger.getDebugObject()
    return objectToDebug
end

return Debugger