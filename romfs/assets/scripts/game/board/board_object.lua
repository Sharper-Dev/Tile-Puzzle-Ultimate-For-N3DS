local GameObject = require("gameobject.m2d_gameobject")
local thisObject = GameObject:new("board")

local Script = thisObject:addComponent("Script")
local Sprite = thisObject:addComponent("Sprite")

function Script.start()
    thisObject.transform:setPosition(160, 120, 2)
    Sprite:setSprite("romfs:/assets/sprites/board/board.png")
    Sprite:setScreen(BOTTOM_SCREEN)
    local distance = 68
    for i = 1, 3 do
        for j = 1, 3 do
            if i == 3 and j == 3 then
                break
            end
            local pieceObject = GameObject.instantiate(dofile("romfs:/assets/scripts/game/piece/piece.lua"))
            pieceObject.transform:setPosition(92 + (j - 1) * distance, 51 + (i - 1) * distance, 3)
            pieceObject.transform:setScale(0.73, 0.73)
            pieceObject.name = "piece_" .. i .. "_" .. j
            local sprite = pieceObject:getComponent("MultiSprite")
            sprite.cellCursor = { x = j - 1, y = i - 1 }
        end
    end
end

return thisObject