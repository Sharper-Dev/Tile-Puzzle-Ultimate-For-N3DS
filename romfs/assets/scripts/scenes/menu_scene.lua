local Scene = require("scenes.m2d_scene")

local thisScene = Scene:new("menu_scene")

thisScene:addGameObject(dofile("romfs:/assets/scripts/objects/top_background.lua"))
thisScene:addGameObject(dofile("romfs:/assets/scripts/objects/bottom_background.lua"))
thisScene:addGameObject(dofile("romfs:/assets/scripts/objects/top_circles.lua"))
thisScene:addGameObject(dofile("romfs:/assets/scripts/objects/bottom_circles.lua"))
thisScene:addGameObject(dofile("romfs:/assets/scripts/objects/menu_canvas.lua"))
thisScene:addGameObject(dofile("romfs:/assets/scripts/objects/play_button.lua"))
-- thisScene:addGameObject(dofile("romfs:/assets/scripts/objects/quit_button.lua"))

return thisScene