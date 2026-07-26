--- The UI Canvas.
--- @module ui_canvas
--- @author Sharper Dev

local Canvas = {}
Canvas.__index = Canvas
local Renderer = require("renderer.m2d_renderer")

function Canvas:new(params)
    local this = setmetatable({}, Canvas)
    this.space = params.space or TOP_SCREEN
    this.enabled = (params.enabled == nil) and true or params.enabled
    this.gameObject = params.gameObject
    this.elements = {}
    return this
end

function Canvas:addElement(element)
    table.insert(self.elements, element)
    Renderer.addRenderTask(element.renderTask, self.space)
end

function Canvas:delElement(element)
	for i, e in ipairs(self.elements) do
		if e.id == element.id then
			table.remove(self.elements, i)
			Renderer.delRenderTask(element.renderTask, self.space)
			return
		end
	end
end

return Canvas