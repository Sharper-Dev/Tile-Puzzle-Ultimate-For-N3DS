--- A component that makes an object draggable.
--- @module components_draggable
--- @author Sharper Dev

local Draggable = {}
Draggable.__index = Draggable

local InputSystem = require("systems.input.m2d_input_system")

--- Creates a new Draggable component.
--- @param gameObject The game object to attach the component to.
function Draggable:new(gameObject)
    self = setmetatable({}, Draggable)

    self.enabled = true
    self.name = "Draggable"
    self.gameObject = gameObject
    self.boxCollider = gameObject:getComponent("BoxCollider")
    if self.boxCollider == nil then
        error("Draggable requires a BoxCollider component")
    end
    self:registerFunctions()

    return self
end
--- Local function that handles the touch down event.
local function onTouchDown(self)
    self.isDragging = true
    self:onDragStart()
end

--- Local function that handles the touch up event.
local function onTouchUp(self)
    self.isDragging = false
    self:onDragEnd()
end

--- Registers the touch down and touch up event handlers to the box collider.
function Draggable:registerFunctions()
    self.boxCollider.onTouchDown = function() onTouchDown(self) end
    self.boxCollider.onTouchUp = function() onTouchUp(self) end
end

--- Checks every frame if is dragging, and moves the object to the touch position.
function Draggable:update()
    if self.isDragging then
        local x, y = InputSystem.getTouch()
        self.gameObject.transform:setPosition(x, y)

        self:onDragging()
    end
end

--- Called when the drag starts.
function Draggable:onDragStart() end

--- Called when the object is being dragged.
function Draggable:onDragging() end

--- Called when the drag ends.
function Draggable:onDragEnd() end

return Draggable