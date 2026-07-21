local Object = require("gameobject.m2d_gameobject"):new()
local Script = require("components.script.m2d_script"):new()
Object:addComponent(Script)

local Canvas = require("components.ui.m2d_canvas")
local Image = require("components.ui.m2d_image")
local Input = require("input.m2d_input_system")
local ScenesManager = require("scenes.m2d_scenes_manager")
local Renderer = require("renderer.m2d_renderer")
local RenderTask = require("renderer.m2d_render_task")
local topCanvas
local bottomCanvas
local bottomBackground

local renderTask = RenderTask:new({
    layer = Object.transform.position.z,
    id = 1,
    execute = function()
        Graphics.fillRect(10, 100, 10, 100, Color.new(255, 255, 255))
    end
})
local renderTask2 = RenderTask:new({
    enabled = false,
    layer = Object.transform.position.z,
    id = 2,
    execute = function()
        Graphics.fillRect(10, 100, 10, 100, Color.new(255, 255, 255))
    end
})

function Script:start()
    -- bottomCanvas = Canvas:new(BOTTOM_SCREEN)
    -- bottomBackground = Image:new({ imagePath = "romfs:/assets/images/background_bottom.png", gameObject = Object })
    -- bottomCanvas:addCanvasComponent(bottomBackground)
    
    Renderer.addRenderTask(renderTask, TOP_SCREEN)
    Renderer.addRenderTask(renderTask2, BOTTOM_SCREEN)
end

function Script:update()
    -- bottomCanvas:draw()
    if Input.getKeyDown(KEY_B) then
        --ScenesManager.loadScene(2)
        renderTask.enabled = not renderTask.enabled
        renderTask2.enabled = not renderTask2.enabled
    end
end

return Object