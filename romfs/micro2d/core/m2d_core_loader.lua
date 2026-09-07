--- The core loader of Micro2D.
--- This module loads the runtime and starts the application.
---
--- It not contains any public functions. See the core_runtime module.
--- @module core_loader
--- @author Sharper Dev
package.path = package.path .. ";romfs:/micro2d/?.lua"

require("m2d_settings")
package.path = package.path .. ";" .. M2D_SETTINGS.PREFABS_PATH .. "?.lua"

require("fonts.m2d_fonts_manager").loadFont("default", "romfs:/micro2d/assets/fonts/dogica_8px")
local m2d_runtime = require("core.m2d_core_runtime")

m2d_runtime._start()

while true do
    m2d_runtime._loop()
end