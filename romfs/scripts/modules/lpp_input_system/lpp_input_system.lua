--[
-- Simple Input System for Lua Player Plus (3DS) by Sharper Dev
-- Lua Player Plus by Rinnegatamante
-- v0.1.0
--]
local InputSystem = {}

local previousInput = 0
local currentInput = 0

local downButtons = 0
local upButtons = 0

local circlePadDeadZone = 20

function InputSystem.readInputs()
    previousInput = currentInput
    currentInput = Controls.read()

    local updated = previousInput ~ currentInput
    downButtons = updated & currentInput
    upButtons = updated & previousInput
end

function InputSystem.getRawInput()
    return currentInput
end

function InputSystem.getCirclePad()
    local x, y = Controls.readCirclePad()
    x = (math.abs(x) > circlePadDeadZone) and x or 0
    y = (math.abs(y) > circlePadDeadZone) and y or 0
    return x, y
end

function InputSystem.getCstick()
    local x, y = Controls.readCstickPad()
    x = (math.abs(x) > circlePadDeadZone) and x or 0
    y = (math.abs(y) > circlePadDeadZone) and y or 0
    return x, y
end

function InputSystem.setCirclePadDeadZone(deadZoneValue)
    circlePadDeadZone = deadZoneValue
end

function InputSystem.getKey(key)
    return Controls.check(currentInput, key)
end

function InputSystem.getKeyDown(key)
    return Controls.check(downButtons, key)
end

function InputSystem.getKeyUp(key)
    return Controls.check(upButtons, key)
end

function InputSystem.getTouch()
	local x, y = Controls.readTouch()
	return {x = x, y = y}
end

return InputSystem
