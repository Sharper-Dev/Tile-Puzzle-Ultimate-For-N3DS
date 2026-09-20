local PieceBuilder = {}
local GameObject = require("gameobject.m2d_gameobject")
local Debugger = require("debugger.m2d_debugger")
local InputSystem = require("systems.input.m2d_input_system")

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

    boxCollider.onCollisionEnter = function(self, collider)
        Debugger.msg("collision enter: " .. self.gameObject.name .. " vs " .. collider.gameObject.name)
    end
    local draggable = pieceObject:addComponent("Draggable")

    return pieceObject
end

return PieceBuilder
