local Renderer = {}

local renderTasksTop = {}
local renderTasksBottom = {}

local function sortTasks(tasksTable)
    local cleanTable = {}
    for _, task in pairs(tasksTable) do
        table.insert(cleanTable, task)
    end
    table.sort(cleanTable, function(a, b)
        return a.layer < b.layer
    end)
    tasksTable = cleanTable
end

function Renderer.addRenderTask(task, screen)
    if task.id == nil then
        error("task.id cannot be nil")
    end
    if screen == TOP_SCREEN then
        table.insert(renderTasksTop, task)
        sortTasks(renderTasksTop)
    else
        table.insert(renderTasksBottom, task)
        sortTasks(renderTasksBottom)
    end
end

function Renderer.removeRenderTask(task, screen)
    if screen == TOP_SCREEN then
        for i, topTask in ipairs(renderTasksTop) do
            if topTask.id == task.id then
                table.remove(renderTasksTop, i)
                break
            end
        end
        sortTasks(renderTasksTop)
    else
        for i, bottomTask in ipairs(renderTasksBottom) do
            if bottomTask.id == task.id then
                table.remove(renderTasksBottom, i)
                break
            end
        end
        sortTasks(renderTasksBottom)
    end
end

function Renderer.drawTop()
    Graphics.initBlend(TOP_SCREEN)
    for _, task in ipairs(renderTasksTop) do
        task.execute()
    end
    Graphics.termBlend()
end

function Renderer.drawBottom()
    Graphics.initBlend(BOTTOM_SCREEN)
    for _, task in ipairs(renderTasksBottom) do
        task.execute()
    end
    Graphics.termBlend()
end

return Renderer