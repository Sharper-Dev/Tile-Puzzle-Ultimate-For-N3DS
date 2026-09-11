local Scene = require("scenes.m2d_scene")

local thisScene = Scene:new("menu_scene")

thisScene:addGameObject(dofile("romfs:/assets/scripts/general/ui/top_background.lua"))
thisScene:addGameObject(dofile("romfs:/assets/scripts/general/ui/bottom_background.lua"))
thisScene:addGameObject(dofile("romfs:/assets/scripts/general/ui/top_circles.lua"))
thisScene:addGameObject(dofile("romfs:/assets/scripts/general/ui/bottom_circles.lua"))
thisScene:addGameObject(dofile("romfs:/assets/scripts/menu/ui/menu_canvas.lua"))
thisScene:addGameObject(dofile("romfs:/assets/scripts/general/ui/play_button.lua"))
thisScene:addGameObject(dofile("romfs:/assets/scripts/general/ui/quit_button.lua"))
thisScene:addGameObject(dofile("romfs:/assets/scripts/menu/ui/top_title.lua"))

return thisScene