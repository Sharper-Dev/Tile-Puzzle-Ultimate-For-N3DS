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

    boxCollider.onCollisionEnter = function(self, collider)
        Debugger.msg("collision enter: " .. self.gameObject.name .. " vs " .. collider.gameObject.name)
    end
    local draggable = pieceObject:addComponent("Draggable")

    draggable.onDragStart = function(self)
        local pieceLayer = self.gameObject.transform.position.z
        local pieceScalex = self.gameObject.transform.scale.x
        local pieceScaley = self.gameObject.transform.scale.y
        self.gameObject.transform:setPosition(nil, nil, pieceLayer + 1)
        self.gameObject.transform:setScale(pieceScalex + 0.2, pieceScaley + 0.2)
    end

    draggable.onDragEnd = function(self)
        local pieceLayer = self.gameObject.transform.position.z
        local pieceScalex = self.gameObject.transform.scale.x
        local pieceScaley = self.gameObject.transform.scale.y
        self.gameObject.transform:setPosition(nil, nil, pieceLayer - 1)
        self.gameObject.transform:setScale(pieceScalex - 0.2, pieceScaley - 0.2)
    end

    return pieceObject
end

return PieceBuilder