local Builder = {}
local GameObject = require("gameobject.m2d_gameobject")

function Builder.createPlace(name)
    local placeObject = GameObject:new(name)
    placeObject.transform:setPosition(50, 50, 3)

    local sprite = placeObject:addComponent("Sprite")
    sprite:setScreen(BOTTOM_SCREEN)
    sprite.imageWidth = 60
    sprite.imageHeight = 60
    local boxCollider = placeObject:addComponent("BoxCollider")
    boxCollider:setSize(62, 62)
    boxCollider:setOffset(-30, -30)
    boxCollider:setMetaLayer(2)
    return placeObject
end

return Builder
