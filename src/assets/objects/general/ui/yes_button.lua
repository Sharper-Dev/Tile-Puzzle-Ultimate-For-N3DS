local uiButton = require("scripts.builders.ui_button_builder")

local thisObject = uiButton.buildButton("yes_button", "Yes")
local thisScript = thisObject:getComponent("Script")

local baseStart = thisScript.start

thisObject.textOffset = { x = 70, y = 25 }
thisObject.transform:setPosition(23, 117, 1)

function thisScript.start()
    baseStart()
    thisObject.transform:setScale(0.7, 0.7)
end

return thisObject