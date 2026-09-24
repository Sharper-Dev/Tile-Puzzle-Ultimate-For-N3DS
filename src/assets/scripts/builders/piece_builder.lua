local PieceBuilder = {}
local GameObject = require("gameobject.m2d_gameobject")

function PieceBuilder.createPiece(name, spritePath)
    local pieceObject = GameObject:new(name)
    pieceObject.transform:setPosition(50, 50, 3)
    pieceObject.colPlaces = {}

    local sprite = pieceObject:addComponent("MultiSprite")
    sprite:setSprite(spritePath)
    sprite:setScreen(BOTTOM_SCREEN)
    sprite.cellSize = { x = 85, y = 85 }
    sprite.cellCursor.x = 0
    sprite.cellCursor.y = 0

    local boxCollider = pieceObject:addComponent("BoxCollider")
    boxCollider:setSize(62, 62)
    boxCollider:setOffset(-30, -30)
    boxCollider:insertIgnoreMetaLayer(1)

    boxCollider.onCollisionEnter = function(self, collider)
        if not self.gameObject.isMoving then return end
        table.insert(self.gameObject.colPlaces, collider.gameObject)
    end

    boxCollider.onCollisionExit = function(self, collider)
        if not self.gameObject.isMoving then return end
        for i, place in ipairs(self.gameObject.colPlaces) do
            if place == collider.gameObject then
                table.remove(self.gameObject.colPlaces, i)
                break
            end
        end
    end
    local draggable = pieceObject:addComponent("Draggable")

    draggable.onDragStart = function(self)
        local pieceLayer = self.gameObject.transform.position.z
        local pieceScalex = self.gameObject.transform.scale.x
        local pieceScaley = self.gameObject.transform.scale.y
        self.gameObject.isMoving = true
        self.gameObject.colPlaces = {}
        self.gameObject.transform:setPosition(nil, nil, pieceLayer + 1)
        self.gameObject.transform:setScale(pieceScalex + 0.2, pieceScaley + 0.2)
    end

    draggable.onDragEnd = function(self)
        local pieceLayer = self.gameObject.transform.position.z
        local pieceScalex = self.gameObject.transform.scale.x
        local pieceScaley = self.gameObject.transform.scale.y

        self.gameObject.isMoving = false
        self.gameObject.transform:setPosition(nil, nil, pieceLayer - 1)
        self.gameObject.transform:setScale(pieceScalex - 0.2, pieceScaley - 0.2)
        local gotNewPlace = false
        local colPlaces = self.gameObject.colPlaces
        for i = 1, #colPlaces do
            if colPlaces[i].currentPiece == nil then
                local rowDistance = math.abs(colPlaces[i].row - self.gameObject.currentPlace.row)
                local colDistance = math.abs(colPlaces[i].column - self.gameObject.currentPlace.column)
                if rowDistance + colDistance == 1 then
                    self.gameObject:placePiece(colPlaces[i])
                    gotNewPlace = true
                    break
                end
            end
        end
        if not gotNewPlace then self.gameObject:placePiece(self.gameObject.currentPlace) end
        if self.gameObject.colPlaces then self.gameObject.colPlaces = {} end
    end

    return pieceObject
end

return PieceBuilder