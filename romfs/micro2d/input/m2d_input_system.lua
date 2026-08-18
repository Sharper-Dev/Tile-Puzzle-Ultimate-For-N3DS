--- Input system as a wrapper around Lua Player Plus Controls Module.
--- @module input_system
--- @author Sharper Dev

local InputSystem = {}
local InputSettings = require("input.m2d_input_settings")

local previousInput = 0
local currentInput = 0

local downButtons = 0
local upButtons = 0

--- Reading Buttons
--- @section reading_buttons

--- Reads the inputs from the controls and updates the input state.
-- 
--- This function should be called or it won't update the input state.
--
--- It is previously called every frame in the Core Runtime loop.
--- @local
function InputSystem.readInputs()
    previousInput = currentInput
    currentInput = Controls.read()

    local updated = previousInput ~ currentInput
    downButtons = updated & currentInput
    upButtons = updated & previousInput
end

------
--- Gets the raw input as a bitmask.
--- @return integer bitmask representing the current input state.
--- @usage local rawInput = InputSystem.getRawInput()
function InputSystem.getRawInput()
    return currentInput
end

------
--- Checks if the specified key is currently pressed.
--- @param key integer
--- @return boolean
--- @usage local isPressed = InputSystem.getKey(KEY_A)
function InputSystem.getKey(key)
    return Controls.check(currentInput, key)
end

--- Checks if the specified key was pressed down this frame.
--- @param key integer
--- @return boolean
--- @usage local isDown = InputSystem.getKeyDown(KEY_A)
function InputSystem.getKeyDown(key)
    return Controls.check(downButtons, key)
end

--- Checks if the specified key was released this frame.
--- @param key integer
--- @return boolean
--- @usage local isUp = InputSystem.getKeyUp(KEY_A)
function InputSystem.getKeyUp(key)
    return Controls.check(upButtons, key)
end

--- Reading Pads
--- @section circle_pad

------
--- Gets the current Circle Pad axis with applied Dead Zone.
--- @return integer X-Axis value.
--- @return integer Y-Axis value.
--- @usage local x, y = InputSystem.getCirclePad()
function InputSystem.getCirclePad()
    local x, y = Controls.readCirclePad()
    local deadZone = InputSettings.getCirclePadDeadZone()
    x = (math.abs(x) > deadZone) and x or 0
    y = (math.abs(y) > deadZone) and y or 0
    return x, y
end

------
--- Gets the current C-Stick axis with applied Dead Zone.
--- @return integer X-Axis value.
--- @return integer Y-Axis value.
--- @usage local x, y = InputSystem.getCstick()
function InputSystem.getCstick()
    local x, y = Controls.readCstickPad()
    local deadZone = InputSettings.getCStickDeadZone()
    x = (math.abs(x) > deadZone) and x or 0
    y = (math.abs(y) > deadZone) and y or 0
    return x, y
end

--- Reading Touch
--- @section reading_touch

------
--- Gets the current touch position.
--- @return integer X-Axis value.
--- @return integer Y-Axis value.
--- @usage local touch = InputSystem.getTouch()
function InputSystem.getTouch()
	return Controls.readTouch()
end

--- Reading Movements
--- @section reading_movements

------
--- Gets the current gyroscope values.
--- @return integer X-Axis value.
--- @return integer Y-Axis value.
--- @return integer Z-Axis value.
--- @usage local x, y, z = InputSystem.getGyro()
function InputSystem.getGyro()
	return Controls.readGyro()
end

------
--- Gets the current accelerometer values.
--- @return integer X-Axis value.
--- @return integer Y-Axis value.
--- @return integer Z-Axis value.
--- @usage local x, y, z = InputSystem.getAccel()
function InputSystem.getAccel()
	return Controls.readAccel()
end

return InputSystem