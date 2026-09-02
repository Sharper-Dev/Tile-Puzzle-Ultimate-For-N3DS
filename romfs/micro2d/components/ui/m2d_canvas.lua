--- The UI Canvas to display elements on the screen.
--- @module components_ui_canvas
--- @author Sharper Dev

local Canvas = {}
Canvas.__index = Canvas

local Renderer = require("renderer.m2d_renderer")

--- The Canvas Constructor.
--- @param gameObject table The game object this canvas is attached to.
--- @return self canvas
function Canvas:new(gameObject)
    self = setmetatable({}, Canvas)
    self.screen = TOP_SCREEN
    self.enabled = true
    self.gameObject = gameObject
    self.gameObject.canvas = self
    self.elements = {}

    return self
end

--- Engine internal functions
--- @section engine_internal

--- Adds an element to the canvas.
--- @param element table
--- @usage
--- canvas:addElement(image)
function Canvas:addElement(element)
    table.insert(self.elements, element)
    if element.renderTask ~= nil then
        Renderer.addRenderTask(element.renderTask, self.screen, Renderer.SPACES.SCREEN)
    end
end
--- Removes an element from the canvas.
--- @param element table
--- @usage
--- canvas:delElement(image)
function Canvas:delElement(element)
	for i, e in ipairs(self.elements or {}) do
		if e == element then
            table.remove(self.elements, i)
            if element.renderTask ~= nil then
                Renderer.removeRenderTask(element.renderTask, self.screen, Renderer.SPACES.SCREEN)
            end
			return
		end
	end
end

function Canvas:switchScreen(screen)
    if self.screen == screen then return end

	for i = 1, #self.elements do
		Renderer.removeRenderTask(self.elements[i].renderTask, self.screen, Renderer.SPACES.SCREEN)
		Renderer.addRenderTask(self.elements[i].renderTask, screen, Renderer.SPACES.SCREEN)
	end
	self.screen = screen
end

function Canvas:destroy()
    for i = 1, #self.elements do
        Canvas:delElement(self.elements[i])
    end
    self.gameObject.canvas = nil
    self.gameObject = nil
    self = nil
end

return Canvas