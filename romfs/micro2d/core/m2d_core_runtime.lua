--- The runtime module of Micro2D.
--- @module core_runtime
--- @author Sharper Dev

local CoreRuntime = {}

local InputSystem = require("input.m2d_input_system")
local ScenesManager = require("scenes.m2d_scenes_manager")
local Renderer = require("renderer.m2d_renderer")
local Debugger = require("debugger.m2d_debugger")
local Time = require("time.m2d_time")

local scenesToUnload = {}

--- Pre-clean the screen by filling it with black.
--
--- When the application starts, this is called to clear the top screen.
--
--- Sometimes when the application starts, the first frame may be a weird texture artifact and this helps to clear it.
local function preClean()
    local sceneTimer = Timer.new()
    
    Controls.disableScreen(TOP_SCREEN) -- I can't show these artifacts :D
    Controls.disableScreen(BOTTOM_SCREEN)

    for _ = 1, 2 do
        Graphics.initBlend(TOP_SCREEN)
        Graphics.fillRect(0, 400, 0, 240, Color.new(0, 0, 0))
        Graphics.termBlend()
        
        Graphics.initBlend(BOTTOM_SCREEN)
        Graphics.fillRect(0, 320, 0, 240, Color.new(0, 0, 0))
        Graphics.termBlend()

        Graphics.flip()
    end

    while Timer.getTime(sceneTimer) < 1000 do
        -- Wait
    end
    Timer.destroy(sceneTimer)
    Controls.enableScreen(TOP_SCREEN)
    Controls.enableScreen(BOTTOM_SCREEN)
end

local function endRuntime()
    Graphics.term()
    System.exit()
end

local function checkScenesToUnload()
    for i = #scenesToUnload, 1, -1 do
        local scene = scenesToUnload[i]
        scene:unload()
        table.remove(scenesToUnload, i)
        Debugger.debugObject(nil)
    end
end

function CoreRuntime.requestUnload(scene)
    table.insert(scenesToUnload, scene)
end

------
--- Called when the game starts.
--- Initializes the graphics and loads the first scene.
function CoreRuntime._start()
    Graphics.init()
    preClean()
    Time.init()
    ScenesManager.loadUniversalScene()
    ScenesManager.loadScene(1)
end

------
--- Called after the game starts and then every frame.
--- Updates the input system, refreshes the screen, updates all components, and renders the active scenes.
function CoreRuntime._loop()
    InputSystem.readInputs()
    local activeScenes = ScenesManager.getActiveScenes()
    for i = 1, #activeScenes do
        for j = 1, #activeScenes[i].gameObjects do
            activeScenes[i].gameObjects[j]:callUpdate()
        end
    end
    Debugger.update()

    Renderer.drawTop()
    Renderer.drawBottom()
    Graphics.flip()

    if InputSystem.getKey(KEY_POWER) then
        endRuntime()
    end
    
    Time.update()
    checkScenesToUnload()
end

return CoreRuntime