local Time = {}

local deltaTimeTimer

function Time.init()
    deltaTimeTimer = Timer.new()
    Time.deltaTime = 0
end

function Time.update()
    Time.deltaTime = Timer.getTime(deltaTimeTimer) / 1000
    Timer.reset(deltaTimeTimer)
end

return Time