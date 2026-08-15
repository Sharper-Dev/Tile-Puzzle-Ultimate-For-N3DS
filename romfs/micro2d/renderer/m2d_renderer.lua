--- The main renderer module.
--- It works with RenderTasks queue to render the game.
--- @module renderer
--- @author Sharper Dev

local Renderer = {}
Renderer.SPACES = {
    WORLD = 1,
    SCREEN = 2
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

--- Sorts the tasks in the given tasks table by their layer.
--- @param screen The screen to sort the tasks for.
--- @param space The space to sort the tasks for.
--- @private
--- @usage sortTasks(TOP_SCREEN, Renderer.SPACES.WORLD)
local function sortTasks(screen, space)
    local tasksTable = tasksPointer[screen][space]

    table.sort(tasksTable, function(a, b) return a.layer < b.layer end)
end

--- Checks if the tasks in the given tasks table need to be sorted by their layer, and sorts them if necessary.
--- @param screen The screen to check the tasks for.
--- @param space The space to check the tasks for.
--- @private
--- @usage checkLayers(TOP_SCREEN, Renderer.SPACES.WORLD)
local function checkLayers(screen, space)
    local tasksTable = tasksPointer[screen][space]
    local hasToSort = false
    for i = 1, #tasksTable do
        if tasksTable[i].previousLayer ~= tasksTable[i].layer then
            tasksTable[i].previousLayer = tasksTable[i].layer
            hasToSort = true
        end
    end
    if hasToSort then
        sortTasks(screen, space)
    end
end
--- Adds a render task to the given screen's task queue.
--- @param task The task to add.
--- @param screen The screen to add the task to.
--- @param space The space to add the task to.
--- @usage Renderer.addRenderTask(task, TOP_SCREEN, Renderer.SPACES.WORLD)
function Renderer.addRenderTask(task, screen, space)
    local tasksTable = tasksPointer[screen][space]
    for i = 1, #tasksTable do
        if tasksTable[i].layer > task.layer then
            table.insert(tasksTable, i, task)
            return
        end
    end
    
    table.insert(tasksTable, task)
end

--- Removes a render task from the given screen's task queue.
--- @param task The task to remove.
--- @param screen The screen to remove the task from.
--- @param space The space to remove the task from.
--- @usage Renderer.removeRenderTask(task, TOP_SCREEN, Renderer.SPACES.WORLD)
function Renderer.removeRenderTask(task, screen, space)
    local tasksTable = tasksPointer[screen][space]
    for i = #tasksTable, 1, -1 do
        if tasksTable[i] == task then
            table.remove(tasksTable, i)
            return
        end
    end
end

--- Draws the top screen's render tasks.
--- This function is called automatically by the core runtime.
function Renderer.drawTop()
    checkLayers(TOP_SCREEN, Renderer.SPACES.WORLD)
    checkLayers(TOP_SCREEN, Renderer.SPACES.SCREEN)
    
    local topTasks = tasksPointer[TOP_SCREEN][Renderer.SPACES.WORLD]

    Graphics.initBlend(TOP_SCREEN)
    
    for i = 1, #topTasks do
        topTasks[i].execute()
    end
    
    topTasks = tasksPointer[TOP_SCREEN][Renderer.SPACES.SCREEN]

    for i = 1, #topTasks do
        topTasks[i].execute()
    end  

    Graphics.termBlend()
end

--- Draws the bottom screen's render tasks.
--- This function is called automatically by the core runtime.
function Renderer.drawBottom()
    checkLayers(BOTTOM_SCREEN, Renderer.SPACES.WORLD)
    checkLayers(BOTTOM_SCREEN, Renderer.SPACES.SCREEN)
    
    local bottomTasks = tasksPointer[BOTTOM_SCREEN][Renderer.SPACES.WORLD]
   
    Graphics.initBlend(BOTTOM_SCREEN)
    
    for i = 1, #bottomTasks do
        bottomTasks[i].execute()
    end
    
    bottomTasks = tasksPointer[BOTTOM_SCREEN][Renderer.SPACES.SCREEN]

    for i = 1, #bottomTasks do
        bottomTasks[i].execute()
    end

    Graphics.termBlend()
end

return Renderer