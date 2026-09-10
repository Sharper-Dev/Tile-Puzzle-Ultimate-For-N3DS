--- The universal scene.
--
--
--- This is a scene that acts like Dont Destroy On Load on Unity, where you can instantiate objects that persist across scenes. It is a common scene and it is loaded by default.
--- @see scenes_scene
--- @module scenes_scene_universal
local Scene = require("scenes.m2d_scene")

local thisScene = Scene:new("universal_scene")

return thisScene