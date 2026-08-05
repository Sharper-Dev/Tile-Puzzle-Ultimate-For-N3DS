--- The render task.
--- @module renderer_render_task
--- @author Sharper Dev

local RenderTask = {}
RenderTask.__index = RenderTask

function RenderTask:new(params)
    self = setmetatable({}, RenderTask)
    self.layer = params.layer or 0
    self.execute = params.execute
    
    return self
end

return RenderTask