local PieceBuilder = {}
local GameObject = require("gameobject.m2d_gameobject")
local Debugger = require("debugger.m2d_debugger")

function PieceBuilder.createPiece(name, spritePath)
    local pieceObject = GameObject:new(name)
    pieceObject.transform:setPosition(50, 50, 3)
    local sprite = pieceObject:addComponent("MultiSprite")
    sprite:setSprite(spritePath)
    sprite:setScreen(BOTTOM_SCREEN)
    sprite.cellSize = { x = 85, y = 85 }
    sprite.cellCursor.x = 0
    sprite.cellCursor.y = 0

    local boxCollider = pieceObject:addComponent("BoxCollider")
    boxCollider:setSize(62, 62)
    boxCollider:setOffset(-30, -30)
    boxCollider.onTouchDown = function(self)
        Debugger.msg("down! I am " .. self.gameObject.name)
    end
    boxCollider.onTouchUp = function(self)
        Debugger.msg("up! I am " .. self.gameObject.name)
    end
    return pieceObject
end

return PieceBuilder
