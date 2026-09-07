--- The module containing the Micro2D engine settings.
--- @module Settings
--- @author Sharper Dev

local Settings = {}

Settings.PREFABS_PATH = "romfs:/assets/scripts/prefabs/"
--- The scenes list to store the paths of the scene scripts.
--
--- You must specify the path to the scene script. So you can load it later by its index.
--- @usage Settings.SCENES[1] = "romfs:/assets/scripts/scenes/sample_scene.lua"
Settings.SCENES = {}

Settings.SCENES[1] = "romfs:/assets/scripts/scenes/menu_scene.lua"
Settings.SCENES[2] = "romfs:/assets/scripts/scenes/game_scene.lua"

_G.M2D_SETTINGS = Settings
