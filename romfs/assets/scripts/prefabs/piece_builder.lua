local PieceBuilder = {}
local GameObject = require("gameobject.m2d_gameobject")

function PieceBuilder.createPiece(name, spritePath)
    local pieceObject = GameObject:new(name)
    pieceObject.transform:setPosition(50, 50, 3)
    local sprite = pieceObject:addComponent("MultiSprite")
    sprite:setSprite(spritePath)
    sprite:setScreen(BOTTOM_SCREEN)
    sprite.cellCursor.x = 0
    sprite.cellCursor.y = 0
    return pieceObject
end

return PieceBuilder
