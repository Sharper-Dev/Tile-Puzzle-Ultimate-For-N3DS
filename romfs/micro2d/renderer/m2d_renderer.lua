--- The main renderer module.
--- It works with RenderTasks queue to render the game.
--- @module renderer
--- @author Sharper Dev

local Renderer = {}
Renderer.SPACES = {
    WORLD = 0,
    SCREEN = 1
}

local worldTopTasks = {}
local screenTopTasks = {}

local worldBottomTasks = {}
local screenBottomTasks = {}

local tasksPointer = {
    [TOP_SCREEN] = {
        [Renderer.SPACES.WORLD] = worldTopTasks,
        [Renderer.SPACES.SCREEN] = screenTopTasks
    },
    [BOTTOM_SCREEN] = {
        [Renderer.SPACES.WORLD] = worldBottomTasks,
        [Renderer.SPACES.SCREEN] = screenBottomTasks
    }
}
local keysBuffer = {
    [TOP_SCREEN] = {
        [Renderer.SPACES.WORLD] = {},
        [Renderer.SPACES.SCREEN] = {}
    },
    [BOTTOM_SCREEN] = {
        [Renderer.SPACES.WORLD] = {},
        [Renderer.SPACES.SCREEN] = {}
    }
}

--- Sorts the tasks in the given tasks table by their layer.
--- @param screen The screen to sort the tasks for.
--- @param space The space to sort the tasks for.
--- @private
--- @usage sortTasks(TOP_SCREEN, Renderer.SPACES.WORLD)
local function sortTasks(screen, space)
    local tasksTable = tasksPointer[screen][space]
    local buffer = keysBuffer[screen][space]

    for i = #buffer, 1, -1 do
        buffer[i] = nil
    end
    
    for key in pairs(tasksTable) do
        table.insert(buffer, key)
    end
    
    table.sort(buffer, function(a, b)
        return tasksTable[a].layer < tasksTable[b].layer
    end)
end


function Renderer.addRenderTask(task, screen, space)
    local tasksTable = tasksPointer[screen][space]
    table.insert(tasksTable, task)
    sortTasks(screen, space)
end

--- Removes a render task from the given screen's task queue.
--- @param task The task to remove.
--- @param screen The screen to remove the task from.
--- @param space The space to remove the task from.
--- @usage Renderer.removeRenderTask(task, TOP_SCREEN, Renderer.SPACES.WORLD)
function Renderer.removeRenderTask(task, screen, space)
    local tasksTable = tasksPointer[screen][space]
    for i, t in ipairs(tasksTable) do
        if t == task then
            table.remove(tasksTable, i)
            break
        end
    end
    sortTasks(screen, space)
end

--- Draws the top screen's render tasks.
--- This function is called automatically by the core runtime.
function Renderer.drawTop()
    Graphics.initBlend(TOP_SCREEN)
    for i in ipairs(keysBuffer[TOP_SCREEN][Renderer.SPACES.WORLD]) do
        local task = tasksPointer[TOP_SCREEN][Renderer.SPACES.WORLD][keysBuffer[TOP_SCREEN][Renderer.SPACES.WORLD][i]]
        task.execute()
    end
    
    for i in ipairs(keysBuffer[TOP_SCREEN][Renderer.SPACES.SCREEN]) do
        local task = tasksPointer[TOP_SCREEN][Renderer.SPACES.SCREEN][keysBuffer[TOP_SCREEN][Renderer.SPACES.SCREEN][i]]
        task.execute()
    end    
    Graphics.termBlend()
end

--- Draws the bottom screen's render tasks.
--- This function is called automatically by the core runtime.
function Renderer.drawBottom()
    Graphics.initBlend(BOTTOM_SCREEN)
    for i in ipairs(keysBuffer[BOTTOM_SCREEN][Renderer.SPACES.WORLD]) do
        local task = tasksPointer[BOTTOM_SCREEN][Renderer.SPACES.WORLD][keysBuffer[BOTTOM_SCREEN][Renderer.SPACES.WORLD][i]]
        task.execute()
    end
    
    for i in ipairs(keysBuffer[BOTTOM_SCREEN][Renderer.SPACES.SCREEN]) do
        local task = tasksPointer[BOTTOM_SCREEN][Renderer.SPACES.SCREEN][keysBuffer[BOTTOM_SCREEN][Renderer.SPACES.SCREEN][i]]
        task.execute()
    end    
    Graphics.termBlend()
end

return Renderer