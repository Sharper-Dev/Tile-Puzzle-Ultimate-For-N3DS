local ScenesSystem = require("systems.scenes.m2d_scenes_system")
local uiButton = require("scripts.builders.ui_button_builder")

local thisObject = uiButton.buildButton("no_button", "No")
local thisScript = thisObject:getComponent("Script")
local thisButton = thisObject:getComponent("Button")

local baseStart = thisScript.start

thisObject.textOffset = { x = 73, y = 25 }
thisObject.transform:setPosition(150, 117, 1)

function thisScript.start()
    baseStart()
    thisObject.transform:setScale(0.7, 0.7)
end

return thisObject