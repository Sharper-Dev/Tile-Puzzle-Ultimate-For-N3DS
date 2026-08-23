--- The UI Button component.
--- @module components_ui_button
--- @author Sharper Dev

local Button = {}
Button.__index = Button

local MathE = require("extender.math.m2d_math")
local InputSystem = require("input.m2d_input_system")
local RenderTask = require("renderer.m2d_render_task")

function Button:new(gameObject, userParam)
    self = setmetatable({}, Button)

    self.enabled = true
    self.gameObject = gameObject
    self.debugMode = false
    self.hasTouch = false
    self:setSize(10, 10)
    self.renderTask = RenderTask:new({
        layer = 10,
        execute = function() return self:render() end
    })
    return self
end
function Button:setCanvas(canvas)
    if self.canvas ~= nil then
        self.canvas:delElement(self)
    end
    self.canvas = canvas
    self.canvas:addElement(self)

    return self
end

function Button.onDown() end
function Button.onHold() end
function Button.onOut() end
function Button.onUp() end
    
function Button:update()
    if not self.enabled then return end
        
    if InputSystem.getKey(KEY_TOUCH) then
        local x, y = InputSystem.getTouch()
        local isInside = MathE.checkAABBPoint(self.gameObject.transform.position.x, self.gameObject.transform.position.y, self.width,
            self.height, x, y)
        if isInside and not self.hasTouch then
            self.onDown()
        end
        if isInside and self.hasTouch then
            self.onHold()
        end
        if not isInside and self.hasTouch then
            self.onOut()
        end
        self.hasTouch = isInside
    else
        if self.hasTouch then
            self.onUp()
        end
        self.hasTouch = false
    end
end

function Button:render()
    if not self.debugMode then return end
	local position = self.gameObject.transform.position
	Graphics.fillEmptyRect(position.x, self.width, position.y, self.height, Color.new(255, 255, 255))
end

function Button:setSize(width, height)
    self.width = width
    self.height = height
    return self
end

function Button:setImage(imageComponent)
    self.imageComponent = imageComponent
end

function Button:setTextComponent(text)
    self.textComponent = text
end

return Button
