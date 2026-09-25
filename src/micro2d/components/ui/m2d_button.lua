--- The UI Button component.
--- @module components_ui_button
--- @author Sharper Dev

local Button = {}
Button.__index = Button

--- The Button constructor.
--- @param gameObject The game object this button is attached to.
--- @return The new Button instance.
function Button:new(gameObject)
    self = setmetatable({}, Button)

    self.enabled = true
    self.name = "Button"
    self.gameObject = gameObject
    self.hasTouch = false
    self.collider = gameObject:getComponent("BoxCollider")
    if not self.collider then
        error("Cannot create button without a BoxCollider component")
    end
    self.collider.button = self
    self.collider.onTouchDown = function() self:onDown() end
    self.collider.onTouchClick = function() self:onClick() end
    self.collider.onTouchUp = function() self:onUp() end
    self:setSize(10, 10)
    return self
end

--- The update function called every frame to update button state.
function Button:update()
    if not self.enabled then return end

    if self.imageComponent then
        self.imageComponent.gameObject.transform:setPosition(self.gameObject.transform.position.x,
            self.gameObject.transform.position.y)
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
    self.collider:setSize(width, height)

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
    self.collider.button = nil
    self.textComponent = nil
    self.imageComponent = nil
    self.gameObject = nil
    self.hasTouch = nil
    self = nil
end

--- Events
--- @section events

--- Called when button is down.
function Button.onDown() end

--- Called when button is held.
function Button.onHold() end

--- Called when button is up.
function Button.onUp() end

--- Called when button is clicked.
function Button.onClick() end

return Button