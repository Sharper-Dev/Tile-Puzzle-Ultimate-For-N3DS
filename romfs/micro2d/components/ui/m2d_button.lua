--- The UI Button component.
--- @module components_ui_button
--- @author Sharper Dev

local Button = {}
Button.__index = Button

local MathE = require("extender.math.m2d_math")
local InputSystem = require("input.m2d_input_system")
local RenderTask = require("renderer.m2d_render_task")
local Debugger = require("debugger.m2d_debugger")

--- The Button constructor.
--- @param gameObject The game object this button is attached to.
--- @return The new Button instance.
function Button:new(gameObject)
    self = setmetatable({}, Button)

    self.enabled = true
    self.name = "Button"
    self.gameObject = gameObject
    self.hasTouch = false
    self:setSize(10, 10)
    self.renderTask = RenderTask:new({
        layer = 10,
        execute = function() return self:render() end
    })
    return self
end

--- The update function called every frame to update button state.
function Button:update()
    if not self.enabled then return end

    if self.imageComponent then
        self.imageComponent.gameObject.transform:setPosition(self.gameObject.transform.position.x,
            self.gameObject.transform.position.y)
    end
    if InputSystem.getKey(KEY_TOUCH) then
        local x, y = InputSystem.getTouch()
        local isInside = MathE.checkAABBPoint(self.gameObject.transform.position.x, self.gameObject.transform.position.y,
            self.width,
            self.height, x, y)
        if isInside and not self.hasTouch and InputSystem.getKeyDown(KEY_TOUCH) then
            self.hasTouch = true
            self.onDown()
        end
        if isInside and self.hasTouch then
            self.hasOut = false
            self.onHold()
        end
        if not isInside and self.hasTouch then
            self.hasOut = true
            self.onOut()
        end
    else
        if self.hasTouch then
            self.onUp()
            if not self.hasOut then
                self.onClick()
            end
        end

        self.hasTouch = false
    end
end

--- Sets the canvas for the button.
--- @param canvas The canvas to set.
--- @return The button instance.
function Button:setCanvas(canvas)
    if self.canvas ~= nil then
        self.canvas:delElement(self)
    end

    self.canvas = canvas
    self.canvas:addElement(self)

    return self
end

--- Sets the size of the button.
--
--- It is necessary to calculate the collision box size.
--- @param width The width of the button.
--- @param height The height of the button.
--- @return The button instance.
--- @usage button:setSize(100, 50)
function Button:setSize(width, height)
    self.width = width
    self.height = height

    return self
end

--- Sets the image component for the button.
--
--- When the button contains an image component, its size will be set to match the image dimensions.
--- @param imageComponent The image component to set.
--- @return The button instance.
--- @usage button:setImageComponent(imageComponent)
function Button:setImageComponent(imageComponent)
    self.imageComponent = imageComponent
    self:setSize(imageComponent.imageWidth, imageComponent.imageHeight)
    imageComponent:setCanvas(self.canvas)
    return self
end

--- Sets the text component for the button.
--- @param textComponent The text component to set.
--- @return The button instance.
--- @usage button:setTextComponent(textComponent)
function Button:setTextComponent(textComponent)
    self.textComponent = textComponent
    textComponent:setCanvas(self.canvas)
    return self
end

--- Destroys the button, removing it from the canvas and cleaning up resources.
--
--- It is called automatically when the scene changes.
function Button:destroy()
    self.canvas:delElement(self)
    self.textComponent = nil
    self.imageComponent = nil
    self.gameObject = nil
    self.hasTouch = nil
    self.renderTask = nil
    self = nil
end

--- Internal render function to render the button collision area. It is called when the debug mode is enabled.
function Button:render()
    if not Debugger.isEnabled() then return end

    local position = self.gameObject.transform.position
    Graphics.fillEmptyRect(position.x, self.width + position.x, position.y, self.height + position.y,
        Color.new(0, 255, 0))
end
--- Events
--- @section events

--- Called when button is down.
function Button.onDown() end

--- Called when button is held.
function Button.onHold() end

--- Called when button is out.
function Button.onOut() end

--- Called when button is up.
function Button.onUp() end

--- Called when button is clicked.
function Button.onClick() end

return Button