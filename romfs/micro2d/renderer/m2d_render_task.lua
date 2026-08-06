--- The render task module.
--- @module renderer_render_task
--- @author Sharper Dev

local RenderTask = {}
RenderTask.__index = RenderTask
--- Creates a new RenderTask.
--
--- params.layer The layer of the RenderTask.
--
--
--- params.execute The function to execute when the RenderTask is executed.
--- @param params The parameters for the RenderTask.
--- @return The new RenderTask.
--- @usage
--- local task = RenderTask:new({
--- layer = 0,
--- execute = function()
---     -- Render code here    
--- end })
function RenderTask:new(params)
    self = setmetatable({}, RenderTask)
    self.layer = params.layer or 0
    self.execute = params.execute
    
    return self
end

return RenderTask