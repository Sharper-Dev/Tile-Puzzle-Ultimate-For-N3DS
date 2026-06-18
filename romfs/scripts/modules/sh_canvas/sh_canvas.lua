local SHCanvas = {}
SHCanvas.__index = SHCanvas

function SHCanvas:new(space)
    local this = setmetatable({}, SHCanvas)
    this.space = space or TOP_SCREEN
    this.components = {}
    return this
end

function SHCanvas:draw()
    Graphics.initBlend(self.space)
    for _, component in ipairs(self.components) do
        if (type(component._drawGPU) == "function") then
            component:_drawGPU(self.space)
        end
    end
    Graphics.termBlend()
    
    --TODO: Remove CPU Rendering and use GPU Rendering instead to render texts
    for _, component in ipairs(self.components) do
        if (type(component._drawCPU) == "function") then
            component:_drawCPU(self.space)
        end
    end
end

function SHCanvas:addCanvasComponent(component)
    table.insert(self.components, component)
    table.sort(self.components, function(a, b) return a.transform.position.z < b.transform.position.z end)
end

return SHCanvas
