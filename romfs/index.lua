package.path = package.path .. ";romfs:/scripts/?.lua;romfs:/scripts/modules/?.lua;romfs:/scripts/modules/?/?.lua"
local m2d_index = require("micro2d.core.m2d_core_index")

m2d_index._start()

while true do
    m2d_index._loop()
end
