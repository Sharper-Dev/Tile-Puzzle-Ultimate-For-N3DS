--- The UI Canvas.
--- @module ui_canvas
--- @author Sharper Dev

local Canvas = {}
Canvas.__index = Canvas

------
--- Creates a new UI Canvas.
--- @param space integer The space to draw the canvas on.
--- @return self The new UI Canvas.
--- @usage local canvas = Canvas:new(TOP_SCREEN)
function Canvas:new(space)
    local this = setmetatable({}, Canvas)
    this.space = space or TOP_SCREEN
    this.components = {}
    return this
end

------
--- Internal function to draw all the canvas components.
--- @usage canvas:draw()
--- @private
function Canvas:draw()
    Graphics.initBlend(self.space)
    for _, component in ipairs(self.components) do
        if (type(component._drawGPU) == "function") then
            component:_drawGPU(self.space)
        end
    end
    Graphics.termBlend()
end

function Canvas:addCanvasComponent(component)
    table.insert(self.components, component)
    table.sort(self.components, function(a, b) return a.transform.position.z < b.transform.position.z end)
end

return Canvas