--- The runtime module of Micro2D.
--- @module core_runtime
--- @author Sharper Dev

local CoreRuntime = {}
local InputSystem = require("input.m2d_input_system")
local ScenesManager = require("scenes.m2d_scenes_manager")
local Renderer = require("renderer.m2d_renderer")

------
--- Called when the app starts.
function CoreRuntime._start()
    Graphics.init()
    ScenesManager.loadScene(1)
end

------
--- Called every frame.
function CoreRuntime._loop()
    InputSystem.readInputs()
    
    Screen.refresh()
    Screen.waitVblankStart()
    
    Screen.clear(TOP_SCREEN)
    Screen.clear(BOTTOM_SCREEN)
    for _, scene in ipairs(ScenesManager.getActiveScenes()) do
        if scene.gameObjects ~= nil then
            for _, obj in ipairs(scene.gameObjects) do
                if obj.enabled then
                    for _, component in ipairs(obj.components) do
                        if component.enabled then
                            component:update()
                        end
                    end
                end
            end
        end
    end
    Renderer.drawTop()
    Renderer.drawBottom()
    Screen.flip()
    
    if InputSystem.getKeyDown(KEY_HOME) or InputSystem.getKeyDown(KEY_POWER) then
        Graphics.term()
        System.exit()
    end
end

return CoreRuntime