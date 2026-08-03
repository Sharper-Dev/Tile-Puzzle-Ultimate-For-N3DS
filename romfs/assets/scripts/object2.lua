local Object2 = require("gameobject.m2d_gameobject"):new("2")
local Script2 = Object2:addComponent("Script", {})
local Input = require("input.m2d_input_system")
local ScenesManager = require("scenes.m2d_scenes_manager")
local Renderer = require("renderer.m2d_renderer")
local RenderTask = require("renderer.m2d_render_task")
local Object1

function Script2:start()
    Object1 = Object2.findByName("1")
    local task = RenderTask:new({
        layer = 0,
        execute = function()
            local pos = Object2.transform:getPosition()
            Graphics.fillRect(pos.x, 50 + pos.x, pos.y, 50 + pos.y, Color.new(255, 255, 255))
              
        end
    })
    local task2 = RenderTask:new({
        layer = 1,
        execute = function()
            local pos1 = Object1.transform:getPosition()
            Graphics.fillRect(pos1.x + 10, 100 + pos1.x, pos1.y, 100 + pos1.y, Color.new(255,255,0))   
        end
    })
    Renderer.addRenderTask(task, TOP_SCREEN)
    Renderer.addRenderTask(task2, TOP_SCREEN)
end

function Script2:update()
    -- Graphics.initBlend(TOP_SCREEN)
    -- local pos = Object2.transform:getPosition()
    -- local pos1 = Object1.transform:getPosition()
    -- Graphics.fillRect(pos.x, 50 + pos.x, pos.y, 50 + pos.y, Color.new(255,255,255))
    -- Graphics.fillRect(pos1.x, 100 + pos1.x, pos1.y, 100 + pos1.y, Color.new(255,255,0))
    -- Graphics.termBlend()
end
return Object2