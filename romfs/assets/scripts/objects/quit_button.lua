local uiButton = require("ui_button")
local prefabInstance = uiButton:new("quit_button")
local thisObject = prefabInstance.gameObject

function prefabInstance.script:start()
    prefabInstance:start()
    thisObject.transform:setPosition(90, 80)
    thisObject.textComponent:setContent("Quit")
end

return thisObject