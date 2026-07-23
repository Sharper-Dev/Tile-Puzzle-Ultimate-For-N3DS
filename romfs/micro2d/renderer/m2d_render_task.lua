local RenderTask = {}
RenderTask.__index = RenderTask

function RenderTask:new(params)
    local this = {}
    this.layer = params.layer or 1
    this.execute = params.execute
    this.enabled = (params.enabled == nil) and true or params.enabled
    setmetatable({}, this)
    return this
end

return RenderTask