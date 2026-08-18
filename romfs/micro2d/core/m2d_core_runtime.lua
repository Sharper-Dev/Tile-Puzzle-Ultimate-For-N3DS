--- The runtime module of Micro2D.
--- @module core_runtime
--- @author Sharper Dev

local CoreRuntime = {}

local InputSystem = require("input.m2d_input_system")
local ScenesManager = require("scenes.m2d_scenes_manager")
local Renderer = require("renderer.m2d_renderer")
local Debugger = require("debugger.m2d_debugger")
local Time = require("time.m2d_time")

--- Pre-clean the screen by filling it with black.
--
--- When the application starts, this is called to clear the top screen.
--
--- Sometimes when the application starts, the first frame may be a weird texture artifact and this helps to clear it.
local function preClean()
    local sceneTimer = Timer.new()
    for _ = 1, 2 do
        Graphics.initBlend(TOP_SCREEN)
        Graphics.fillRect(0, 400, 0, 320, Color.new(0, 0, 0))
        Graphics.termBlend()
        Screen.flip()
    end
    while Timer.getTime(sceneTimer) < 1000 do
        -- Wait
    end
    Timer.destroy(sceneTimer)
end

------
--- Called when the game starts.
--- Initializes the graphics and loads the first scene.
function CoreRuntime._start()
    Graphics.init()
    Time.init()
    preClean()
    ScenesManager.loadScene(1)
end

------
--- Called after the game starts and then every frame.
--- Updates the input system, refreshes the screen, updates all components, and renders the active scenes.
function CoreRuntime._loop()
    InputSystem.readInputs()
    
    Screen.refresh()
    
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
    Debugger.update()

    Renderer.drawTop()
    Renderer.drawBottom()
    Screen.flip()

    if InputSystem.getKey(KEY_POWER) then
        Graphics.term()
        System.exit()
    end

    Time.update()
    
    Screen.waitVblankStart()
end

return CoreRuntime