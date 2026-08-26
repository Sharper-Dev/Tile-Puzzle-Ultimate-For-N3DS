local GameObject = require("gameobject.m2d_gameobject")
local ScenesManager = require("scenes.m2d_scenes_manager")

local thisObject = GameObject:new("test_button")
local Script = thisObject:addComponent("Script", {})
local Button = thisObject:addComponent("Button", {})
local Canvas

function Script.start()
    Canvas = GameObject.findByName("Canvas")
    thisObject.transform:setPosition(0, 0)
    Button:setSize(100, 50)
    Button:setCanvas(Canvas.canvas)
end

function Button.onClick()
    ScenesManager.loadScene(1)
end
return thisObject