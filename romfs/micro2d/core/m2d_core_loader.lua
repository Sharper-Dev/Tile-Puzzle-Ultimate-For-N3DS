--- The core loader of Micro2D.
--- This module loads the runtime and starts the application. It not contains any public functions.
--- @module core_loader
--- @author Sharper Dev

package.path = package.path .. ";romfs:/micro2d/?.lua"
local m2d_runtime = require("core.m2d_core_runtime")

m2d_runtime._start()

while true do
    m2d_runtime._loop()
end