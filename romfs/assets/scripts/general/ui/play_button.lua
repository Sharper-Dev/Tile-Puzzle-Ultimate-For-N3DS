local ScenesManager = require("scenes.m2d_scenes_manager")
local uiButton = require("ui_button")

local thisObject = uiButton.buildButton("play_button", "Play")
local script = thisObject:getComponent("Script")
local button = thisObject:getComponent("Button")

local baseStart = script.start

function script.start()
    baseStart()
    thisObject.textOffset = { x = 50, y = 25 }
    thisObject.transform:setPosition(90, 50, 1)
end

function button.onClick()
    ScenesManager.loadScene(2)
end

return thisObject