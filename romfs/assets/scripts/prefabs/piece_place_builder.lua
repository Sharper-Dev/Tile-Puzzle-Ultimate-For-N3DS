local PiecePlaceBuilder = {}
local GameObject = require("gameobject.m2d_gameobject")

function PiecePlaceBuilder.createPlace(name)
    local pieceObject = GameObject:new(name)
    pieceObject.transform:setPosition(50, 50, 3)

    local sprite = pieceObject:addComponent("Sprite")
    sprite:setScreen(BOTTOM_SCREEN)
    sprite.imageWidth = 60
    sprite.imageHeight = 60

    return pieceObject
end

return PiecePlaceBuilder
