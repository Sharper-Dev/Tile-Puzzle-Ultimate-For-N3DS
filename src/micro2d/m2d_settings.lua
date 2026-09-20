--- The module containing the Micro2D engine settings.
--- @module settings
--- @author Sharper Dev

local Settings = {}

--- The path to the game assets directory. So you can use `require()` to load scripts from this directory.
--- @usage Settings.ASSETS_PATH = "romfs:/assets/"
Settings.ASSETS_PATH = "romfs:/assets/"

--- The scenes list to store the paths of the scene scripts.
--
--- You must specify the path to the scene script. So you can load it later by its index.
--- @usage Settings.SCENES[1] = "romfs:/assets/scripts/scenes/sample_scene.lua"
Settings.SCENES = {}

Settings.SCENES[1] = "romfs:/assets/scenes/menu_scene.lua"
Settings.SCENES[2] = "romfs:/assets/scenes/game_scene.lua"

_G.M2D_SETTINGS = Settings