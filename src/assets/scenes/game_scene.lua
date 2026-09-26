local Scene = require("systems.scenes.m2d_scene")

local thisScene = Scene:new("game_scene")

thisScene:addGameObject(dofile("romfs:/assets/objects/general/ui/top_background.lua"))
thisScene:addGameObject(dofile("romfs:/assets/objects/general/ui/bottom_background.lua"))
thisScene:addGameObject(dofile("romfs:/assets/objects/general/ui/top_circles.lua"))
thisScene:addGameObject(dofile("romfs:/assets/objects/general/ui/bottom_circles.lua"))
thisScene:addGameObject(dofile("romfs:/assets/objects/game/board/board_object.lua"))
thisScene:addGameObject(dofile("romfs:/assets/objects/game/ui/game_canvas.lua"))
thisScene:addGameObject(dofile("romfs:/assets/objects/general/ui/quit_panel.lua"))

return thisScene