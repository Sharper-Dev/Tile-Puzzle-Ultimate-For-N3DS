--- The main renderer module.
--- It works with RenderTasks queue to render the game.
--- @module renderer
--- @author Sharper Dev

local Renderer = {}

local renderTasksTop = {}
local renderTasksBottom = {}

--- Sorts the tasks in the given tasks table by their layer.
--- @param tasksTable The tasks table to sort.
--- @private
--- @usage sortTasks(renderTasksTop)
local function sortTasks(tasksTable)
    table.sort(tasksTable, function(a, b)
        return a.layer < b.layer
    end)
end

--- Adds a render task to the given screen's task queue.
--- @param task The task to add.
--- @param screen The screen to add the task to.
--- @usage Renderer.addRenderTask(task, TOP_SCREEN)
function Renderer.addRenderTask(task, screen)
    if screen == TOP_SCREEN then
        table.insert(renderTasksTop, task)
        sortTasks(renderTasksTop)
    else
        table.insert(renderTasksBottom, task)
        sortTasks(renderTasksBottom)
    end
end
--- Removes a render task from the given screen's task queue.
--- @param task The task to remove.
--- @param screen The screen to remove the task from.
--- @usage Renderer.delRenderTask(task, TOP_SCREEN)
function Renderer.delRenderTask(task, screen)
    if screen == TOP_SCREEN then
        for i, topTask in ipairs(renderTasksTop) do
            if topTask == task then
                table.remove(renderTasksTop, i)
                break
            end
        end
        sortTasks(renderTasksTop)
    else
        for i, bottomTask in ipairs(renderTasksBottom) do
            if bottomTask == task then
                table.remove(renderTasksBottom, i)
                break
            end
        end
        sortTasks(renderTasksBottom)
    end
end

--- Draws the top screen's render tasks.
--- This function is called automatically by the core runtime.
function Renderer.drawTop()
    Graphics.initBlend(TOP_SCREEN)
    for _, task in ipairs(renderTasksTop) do
        task.execute()
    end
    Graphics.termBlend()
end

--- Draws the bottom screen's render tasks.
--- This function is called automatically by the core runtime.
function Renderer.drawBottom()
    Graphics.initBlend(BOTTOM_SCREEN)
    for _, task in ipairs(renderTasksBottom) do
        task.execute()
    end
    Graphics.termBlend()
end

return Renderer