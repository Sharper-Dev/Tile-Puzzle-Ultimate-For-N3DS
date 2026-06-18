package.path = package.path .. ";romfs:/scripts/?.lua;romfs:/scripts/modules/?.lua;romfs:/scripts/modules/?/?.lua"

local InputSystem = require("lpp_input_system")

local function setup()
    
end

setup()

local function update()
    InputSystem.readInputs()
end

while true do
    Screen.refresh()
    Screen.waitVblankStart()
    
    Screen.clear(TOP_SCREEN)
    Screen.clear(BOTTOM_SCREEN)

    update()
    
    Screen.flip()
    
    if InputSystem.getKeyDown(KEY_HOME) or InputSystem.getKeyDown(KEY_POWER) then
        Graphics.term()
        System.exit()
    end
end
