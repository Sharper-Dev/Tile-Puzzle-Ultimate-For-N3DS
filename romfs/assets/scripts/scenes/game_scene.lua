local Scene = require("scenes.m2d_scene")

local thisScene = Scene:new("game_scene")

thisScene:addGameObject(dofile("romfs:/assets/scripts/general/ui/top_background.lua"))
thisScene:addGameObject(dofile("romfs:/assets/scripts/general/ui/bottom_background.lua"))
thisScene:addGameObject(dofile("romfs:/assets/scripts/general/ui/top_circles.lua"))
thisScene:addGameObject(dofile("romfs:/assets/scripts/general/ui/bottom_circles.lua"))
thisScene:addGameObject(dofile("romfs:/assets/scripts/game/board/board_object.lua"))

return thisScene