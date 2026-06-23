--- Input system settings.
--- @module input_settings
--- @author Sharper Dev

local InputSettings = {}
local circlePadDeadZone = 20
local cStickDeadZone = 20

--- Circle Pad
--- @section circle_pad

------
--- Sets the dead zone for the circle pad.
--
--- The default value is 20.
--- @param value integer The dead zone value.
--- @usage InputSettings.setCirclePadDeadZone(10)
function InputSettings.setCirclePadDeadZone(value)
    circlePadDeadZone = value
end

--- Returns the dead zone for the circle pad.
-- 
--- The default value is 20.
--- @return integer The dead zone value.
--- @usage local deadZone = InputSettings.getCirclePadDeadZone()
function InputSettings.getCirclePadDeadZone()
    return circlePadDeadZone
end

--- C-Stick
--- @section c_stick

--- Sets the dead zone for the c-stick.
--- @param value integer The dead zone value.
--- @usage InputSettings.setCStickDeadZone(10)
function InputSettings.setCStickDeadZone(value)
    cStickDeadZone = value
end

--- Returns the dead zone for the c-stick.
--- @return integer The dead zone value.
--- @usage local deadZone = InputSettings.getCStickDeadZone()
function InputSettings.getCStickDeadZone()
    return cStickDeadZone
end

--- Movements
--- @section movements

------
--- Enables or disables the movement controls (gyroscope and accelerometer).
--- @param state boolean Whether to enable or disable the controls.
--- @usage InputSettings.setMovementsState(true)
function InputSettings.setMovementsState(state)
    if state then
        Controls.enableGyro(state)
        Controls.enableAccel(state)
    else
        Controls.disableGyro(state)
        Controls.disableAccel(state)
    end
end

return InputSettings