local RenderTask = {}

function RenderTask:new(params)
    local this = {}
    this.layer = params.layer
    this.execute = params.execute
    this.id = params.id or nil
    setmetatable(this, {__index = RenderTask})
    return this
end

return RenderTask