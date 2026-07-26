local Scene = require("scenes.m2d_scene")
local SampleScene = Scene:new()

SampleScene:addGameObject(dofile("romfs:/assets/scripts/test_object.lua"))
SampleScene:addGameObject(dofile("romfs:/assets/scripts/object2.lua"))

return SampleScene