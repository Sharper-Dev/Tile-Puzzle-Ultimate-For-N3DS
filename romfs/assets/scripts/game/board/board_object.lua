local GameObject = require("gameobject.m2d_gameobject")
local thisObject = GameObject:new("board")

local Script = thisObject:addComponent("Script")
local Sprite = thisObject:addComponent("Sprite")

function Script.start()
    thisObject.transform:setPosition(160, 120, 2)
    Sprite:setSprite("romfs:/assets/sprites/board/board.png")
    Sprite:setScreen(BOTTOM_SCREEN)
    local distance = 65
    for i = 1, 3 do
        for j = 1, 3 do
            if i == 3 and j == 3 then
                break
            end
            local pieceObject = GameObject.instantiate(dofile("romfs:/assets/scripts/game/piece/piece.lua"))
            pieceObject.transform:setPosition(95 + (j - 1) * distance, 54 + (i - 1) * distance, 3)
            pieceObject.transform:setScale(0.7, 0.7)
            pieceObject.name = "piece_" .. i .. "_" .. j
            local sprite = pieceObject:getComponent("MultiSprite")
            sprite.cellCursor = { x = j - 1, y = i - 1 }
        end
    end
end

return thisObject