local uiButton = require("scripts.builders.ui_button_builder")
local Runtime = require("core.m2d_core_runtime")

local thisObject = uiButton.buildButton("quit_button", "Quit")

local thisScript = thisObject:getComponent("Script")
local thisButton = thisObject:getComponent("Button")

local baseStart = thisScript.start

function thisScript.start()
    baseStart()
    thisObject.textOffset = { x = 62, y = 23 }
    thisObject.transform:setPosition(90, 120, 1)
end

function thisButton.onClick()
    Runtime.endRuntime()
end

return thisObject