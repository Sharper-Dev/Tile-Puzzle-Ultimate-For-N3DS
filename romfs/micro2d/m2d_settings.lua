--- The module containing the Micro2D engine settings.
--- @module settings
--- @author Sharper Dev

local settings = {}

--- The scenes list to store the paths of the scene scripts.
--
--- You must specify the path to the scene script. So you can load it later by its index.
--- @usage settings.SCENES[1] = "romfs:/assets/scripts/scenes/sample_scene.lua"
settings.SCENES = {}

settings.SCENES[1] = "romfs:/assets/scripts/scenes/sample_scene.lua"

return settings