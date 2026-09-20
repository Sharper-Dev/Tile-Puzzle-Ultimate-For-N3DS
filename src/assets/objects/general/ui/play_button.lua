local ScenesManager = require("systems.scenes.m2d_scenes_system")
local uiButton = require("scripts.builders.ui_button_builder")

local thisObject = uiButton.buildButton("play_button", "Play")
local thisScript = thisObject:getComponent("Script")
local thisButton = thisObject:getComponent("Button")

local baseStart = thisScript.start

function thisScript.start()
    baseStart()
    thisObject.textOffset = { x = 62, y = 23 }
    thisObject.transform:setPosition(90, 50, 1)
    ---ScenesManager.loadScene(2)
end

function thisButton.onClick()
    ScenesManager.loadScene(2)
end

return thisObject