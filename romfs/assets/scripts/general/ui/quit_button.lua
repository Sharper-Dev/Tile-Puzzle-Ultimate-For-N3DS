local uiButton = require("prefabs.ui_button")
local Runtime = require("core.m2d_core_runtime")

local thisObject = uiButton.buildButton("quit_button", "Quit")

local script = thisObject:getComponent("Script")
local button = thisObject:getComponent("Button")

local baseStart = script.start

function script.start()
    baseStart()
    thisObject.textOffset = { x = 50, y = 25 }
    thisObject.transform:setPosition(90, 120, 1)
end

function button.onClick()
    Runtime.endRuntime()
end

return thisObject