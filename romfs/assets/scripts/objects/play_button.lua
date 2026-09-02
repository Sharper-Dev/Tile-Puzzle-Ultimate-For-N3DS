local GameObject = require("gameobject.m2d_gameobject")
local ScenesManager = require("scenes.m2d_scenes_manager")

local thisObject = GameObject:new("play_button")
local Script = thisObject:addComponent("Script")
local Button = thisObject:addComponent("Button")
local Image = thisObject:addComponent("Image")

local Canvas

function Script.start()
    Image:setImage("romfs:/assets/sprites/buttons/button_large.png")
    Canvas = GameObject.findByName("Canvas")
    thisObject.transform:setPosition(0, 0)
    Button:setCanvas(Canvas.canvas)
    Button:setImageComponent(Image)
end

function Button.onClick()
    ScenesManager.loadScene(2)
end
return thisObject