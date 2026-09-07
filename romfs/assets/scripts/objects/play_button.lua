local GameObject = require("gameobject.m2d_gameobject")
local ScenesManager = require("scenes.m2d_scenes_manager")

local thisObject = GameObject:new("play_button")
local Script = thisObject:addComponent("Script")
local Button = thisObject:addComponent("Button")
local Image = thisObject:addComponent("Image")
local textObject
local textComponent
local textOffset = { x = 50, y = 25 }

function Script.start()
    thisObject.transform:setPosition(90, 50, 0)
    textObject = GameObject.instantiate(GameObject:new("play_text"))
    local canvasObject = GameObject.findByName("Canvas")

    textObject.transform:setPosition(nil, nil, thisObject.transform.position.z + 1)
    textObject.transform:setScale(2, 2)

    textComponent = textObject:addComponent("Text")
    textComponent:setCanvas(canvasObject.canvas)
    textComponent:setContent("Play")

    Image:setImage("romfs:/assets/sprites/buttons/button_large.png")
    Image.pivot = 0.5

    Button:setCanvas(canvasObject.canvas)
    Button:setImageComponent(Image)
end

function Script.update()
    textObject.transform:setPosition(thisObject.transform.position.x + textOffset.x,
        thisObject.transform.position.y + textOffset.y)
end

function Button.onClick()
    ScenesManager.loadScene(2)
end

function thisObject:onDestroy()
    textObject = nil
    textComponent = nil
end

return thisObject