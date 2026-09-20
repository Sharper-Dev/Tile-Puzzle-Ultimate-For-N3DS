--- A component that makes an object draggable.
--- @module components_draggable
--- @author Sharper Dev

local Draggable = {}
Draggable.__index = Draggable

local Debugger = require("debugger.m2d_debugger")
local InputSystem = require("systems.input.m2d_input_system")

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

local function onTouchDown(self)
    Debugger.msg("down! I am " .. self.gameObject.name)
    self.isDragging = true
    self:onDragStart()
end

local function onTouchUp(self)
    self.isDragging = false
    self:onDragEnd()
end

function Draggable:registerFunctions()
    self.boxCollider.onTouchDown = function() onTouchDown(self) end
    self.boxCollider.onTouchUp = function() onTouchUp(self) end
end

function Draggable:update()
    if self.isDragging then
        local x, y = InputSystem.getTouch()
        self.gameObject.transform:setPosition(x, y)

        self:onDragging()
    end
end

function Draggable:onDragStart() end
function Draggable:onDragging() end
function Draggable:onDragEnd() end

return Draggable