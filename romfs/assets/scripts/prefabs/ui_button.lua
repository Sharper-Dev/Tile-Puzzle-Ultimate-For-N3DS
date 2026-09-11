local GameObject = require("gameobject.m2d_gameobject")

local Builder = {}

function Builder.buildButton(name, content)
    local buttonObject = GameObject:new(name)
    buttonObject.textOffset = { x = 0, y = 0 }
    local scriptComponent = buttonObject:addComponent("Script")
    local buttonComponent = buttonObject:addComponent("Button")
    local imageComponent = buttonObject:addComponent("Image")

    local textObject
    local textComponent

    scriptComponent.start = function()
        textObject = GameObject.instantiate(GameObject:new(name .. "_text"), nil)
        local canvasObject = GameObject.findByName("canvas")

        textObject.transform:setPosition(nil, nil, buttonObject.transform.position.z + 1)
        textObject.transform:setScale(2, 2)

        textComponent = textObject:addComponent("Text")
        textComponent:setCanvas(canvasObject.canvas)
        textComponent:setContent(content)

        imageComponent:setImage("romfs:/assets/sprites/buttons/button_large.png")
        imageComponent.pivot = 0.5

        buttonComponent:setCanvas(canvasObject.canvas)
        buttonComponent:setImageComponent(imageComponent)
    end
    scriptComponent.update = function()
        textObject.transform:setPosition(buttonObject.transform.position.x + buttonObject.textOffset.x,
            buttonObject.transform.position.y + buttonObject.textOffset.y, buttonObject.transform.position.z + 1)
    end
    return buttonObject
end
return Builder