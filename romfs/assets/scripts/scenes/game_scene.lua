local Scene = require("scenes.m2d_scene")

local thisScene = Scene:new()

thisScene:addGameObject(dofile("romfs:/assets/scripts/objects/top_background.lua"))
thisScene:addGameObject(dofile("romfs:/assets/scripts/objects/bottom_background.lua"))
thisScene:addGameObject(dofile("romfs:/assets/scripts/objects/top_circles.lua"))
thisScene:addGameObject(dofile("romfs:/assets/scripts/objects/bottom_circles.lua"))
thisScene:addGameObject(dofile("romfs:/assets/scripts/canvas_object.lua"))
thisScene:addGameObject(dofile("romfs:/assets/scripts/objects/test_button.lua"))

return thisScene