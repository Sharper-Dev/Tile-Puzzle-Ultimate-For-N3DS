local PieceBuilder = require("scripts.builders.piece_builder")

local thisObject = PieceBuilder.createPiece("piece", "romfs:/assets/sprites/pieces/numbers/numbers.png")

function thisObject:placePiece(place)
    if self.currentPlace ~= place then
        place.currentPiece = thisObject
        if self.currentPlace then self.currentPlace.currentPiece = nil end
        self.currentPlace = place
    end

    local posx = place.transform.position.x
	local posy = place.transform.position.y
	self.transform:setPosition(posx, posy)
end

return thisObject