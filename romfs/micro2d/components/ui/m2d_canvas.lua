--- The UI Canvas.
--- @module ui_canvas
--- @author Sharper Dev

local Canvas = {}
Canvas.__index = Canvas
local Renderer = require("renderer.m2d_renderer")

function Canvas:new(gameObject, userParam)
    self = setmetatable({}, Canvas)
    self.space = userParam or TOP_SCREEN
    self.enabled = true
    self.gameObject = gameObject
    self.gameObject.canvas = self
    self.elements = {}
    
    return self
end
function Canvas:start() end
function Canvas:update() end

function Canvas:addElement(element)
    table.insert(self.elements, element)
    Renderer.addRenderTask(element.renderTask, self.space)
end

function Canvas:delElement(element)
	for i, e in ipairs(self.elements) do
		if e == element then
			table.remove(self.elements, i)
			Renderer.delRenderTask(element.renderTask, self.space)
			return
		end
	end
end

return Canvas