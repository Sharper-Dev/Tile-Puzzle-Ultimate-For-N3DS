local ScenesManager = require("systems.scenes.m2d_scenes_system")
local uiButton = require("prefabs.ui_button")

local thisObject = uiButton.buildButton("play_button", "Play")
local script = thisObject:getComponent("Script")
local button = thisObject:getComponent("Button")

local baseStart = script.start

function script.start()
    baseStart()
    thisObject.textOffset = { x = 62, y = 23 }
    thisObject.transform:setPosition(90, 50, 1)
    ---ScenesManager.loadScene(2)
end

function button.onClick()
    ScenesManager.loadScene(2)
end

return thisObject