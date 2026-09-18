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
    
    boxCollider.onTouchDown = function(self)
        Debugger.msg("down! I am " .. self.gameObject.name)
        self.dragging = true
        local pieceLayer = self.gameObject.transform.position.z
        self.gameObject.transform:setPosition(nil, nil, pieceLayer + 1)
    end

    boxCollider.onTouchStay = function(self)
        if not self.dragging then return end
        local x, y = InputSystem.getTouch()

        self.gameObject.transform:setPosition(x, y)
    end

    boxCollider.onTouchUp = function(self)
        self.dragging = false
        local pieceLayer = self.gameObject.transform.position.z
        self.gameObject.transform:setPosition(nil, nil, pieceLayer - 1)
    end
    return pieceObject
end

return PieceBuilder
