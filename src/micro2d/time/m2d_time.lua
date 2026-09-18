--- The Time module.
--- @module time
--- @author Sharper Dev

local Time = {}

--- The delta time between frames in seconds.
Time.deltaTime = 0
local deltaTimeTimer

--- Initializes the Time module.
function Time.init()
    deltaTimeTimer = Timer.new()
    Time.deltaTime = 0
end

--- Updates the Time module.
function Time.update()
    Time.deltaTime = Timer.getTime(deltaTimeTimer) / 1000
    Timer.reset(deltaTimeTimer)
end

return Time