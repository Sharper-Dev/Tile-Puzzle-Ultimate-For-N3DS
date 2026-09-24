local Script = {}
local GameObject = require("gameobject.m2d_gameobject")
local Shuffler = require("scripts.objects.board.board_shuffler_script")
local pieces = {}
local places = {}

local function generate(isPiece, path)
    local distance = 68
    local name = (isPiece) and "piece_" or "place_"

    for i = 1, 3 do
        for j = 1, 3 do
            if i == 3 and j == 3 and isPiece then
                break
            end
            local object = GameObject.instantiate(dofile(path))
            object.transform:setScale(0.73, 0.73)
            object.name = name .. i .. "_" .. j

            if isPiece then
                object.transform:setPosition(0, 0)
                object.number = (i - 1) * 3 + j
                local sprite = object:getComponent("MultiSprite")
                sprite.cellCursor = { x = j - 1, y = i - 1 }
                table.insert(pieces, object)
            else
                object.transform:setPosition(92 + (j - 1) * distance, 51 + (i - 1) * distance, 3)
                object.row = i
                object.column = j
                table.insert(places, object)
            end
        end
    end
end

function Script:start()
    self.transform:setPosition(160, 120, 2)

    local Sprite = self:getComponent("Sprite")
    Sprite:setSprite("romfs:/assets/sprites/board/board.png")
    Sprite:setScreen(BOTTOM_SCREEN)
    generate(false, "romfs:/assets/objects/game/piece/place/piece_place.lua")
    generate(true, "romfs:/assets/objects/game/piece/piece.lua")
    self.pieces = pieces
    self.places = places
    Shuffler.shuffle(self)
end

return Script