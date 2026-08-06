--- The runtime module of Micro2D.
--- @module core_runtime
--- @author Sharper Dev

local CoreRuntime = {}
local InputSystem = require("input.m2d_input_system")
local ScenesManager = require("scenes.m2d_scenes_manager")
local Renderer = require("renderer.m2d_renderer")

------
--- Called when the game starts.
--- Initializes the graphics and loads the first scene.
function CoreRuntime._start()
    Graphics.init()
    ScenesManager.loadScene(1)
end

------
--- Called after the game starts and then every frame.
--- Updates the input system, refreshes the screen, updates all components, and renders the active scenes.
function CoreRuntime._loop()
    InputSystem.readInputs()
    
    Screen.refresh()
    Screen.waitVblankStart()
    
    Screen.clear(TOP_SCREEN)
    Screen.clear(BOTTOM_SCREEN)
    for _, scene in ipairs(ScenesManager.getActiveScenes()) do
        for _, obj in ipairs(scene.gameObjects or {}) do
            for _, component in ipairs(obj.enabled and obj.components or {}) do
                if component.enabled then
                    component:update()
                end
            end
        end
    end
    Renderer.drawTop()
    Renderer.drawBottom()
    Screen.flip()
    
    if InputSystem.getKeyDown(KEY_POWER) then
        Graphics.term()
        System.exit()
    end
end

return CoreRuntime