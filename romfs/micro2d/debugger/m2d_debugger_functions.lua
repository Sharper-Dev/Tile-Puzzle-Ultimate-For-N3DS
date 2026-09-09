--- Debugger module containing functions for the Micro2D debugger.
--- @module debugger_functions
--- @author Sharper Dev

local Functions = {}
local InputSystem = require("input.m2d_input_system")
local ScenesManager = require("scenes.m2d_scenes_manager")
local DebuggerUI = require("debugger.m2d_debugger_ui")

local functionKey = KEY_L
local quickStepKey = KEY_R
local disableKey = KEY_B
local switchToTopKey = KEY_DUP
local switchToBottomKey = KEY_DDOWN
local switchObjectToNextKey = KEY_DRIGHT
local switchObjectToPrevKey = KEY_DLEFT

local function switchObject(isForward)
    local Debugger = require("debugger.m2d_debugger")
    local objectCount = #ScenesManager.getActiveScenes()[1].gameObjects
    local direction = isForward and 1 or -1

    Debugger.currentObjectIndex = (Debugger.currentObjectIndex + direction) % objectCount

    if Debugger.currentObjectIndex < 1 then
        Debugger.currentObjectIndex = objectCount
    end

    Debugger.debugObject(ScenesManager.getActiveScenes()[1].gameObjects[Debugger.currentObjectIndex])
end

function Functions.detectMove()
    local Debugger = require("debugger.m2d_debugger")

    if Debugger.getDebugObject() and not InputSystem.getKey(functionKey) then
        local step = (InputSystem.getKey(quickStepKey)) and 10 or 1
        if InputSystem.getKeyDown(KEY_DUP) then
            Debugger.getDebugObject().transform:translate(0, -step)
        end
        if InputSystem.getKeyDown(KEY_DDOWN) then
            Debugger.getDebugObject().transform:translate(0, step)
        end
        if InputSystem.getKeyDown(KEY_DLEFT) then
            Debugger.getDebugObject().transform:translate(-step, 0)
        end
        if InputSystem.getKeyDown(KEY_DRIGHT) then
            Debugger.getDebugObject().transform:translate(step, 0)
        end
    end
end

function Functions.detectFunction()
    local Debugger = require("debugger.m2d_debugger")
    
    if InputSystem.getKey(functionKey) then
        if InputSystem.getKeyDown(switchToTopKey) then
            DebuggerUI.switchDebugScreen(TOP_SCREEN)
        elseif InputSystem.getKeyDown(switchToBottomKey) then
            DebuggerUI.switchDebugScreen(BOTTOM_SCREEN)
        end
        if InputSystem.getKeyDown(disableKey) then
            Debugger.setEnable(false)
            DebuggerUI.objects["DEBUGGER_CANVAS"].canvas.enabled = false
        end
        if InputSystem.getKeyDown(switchObjectToNextKey) then
            switchObject(true)
        elseif InputSystem.getKeyDown(switchObjectToPrevKey) then
            switchObject(false)
        end
    end
end

return Functions