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

function Draggable:update()
    if self.isDragging then
        self:onDragging()
    end
end

function Draggable:onDragStart()
    local pieceLayer = self.gameObject.transform.position.z
    local pieceScalex = self.gameObject.transform.scale.x
    local pieceScaley = self.gameObject.transform.scale.y
    self.gameObject.transform:setPosition(nil, nil, pieceLayer + 1)
    self.gameObject.transform:setScale(pieceScalex + 0.2, pieceScaley + 0.2)
end

function Draggable:onDragging()
    local x, y = InputSystem.getTouch()

    self.gameObject.transform:setPosition(x, y)
end

function Draggable:onDragEnd()
    self.dragging = false
    local pieceLayer = self.gameObject.transform.position.z
    local pieceScalex = self.gameObject.transform.scale.x
    local pieceScaley = self.gameObject.transform.scale.y
    self.gameObject.transform:setPosition(nil, nil, pieceLayer - 1)
    self.gameObject.transform:setScale(pieceScalex - 0.2, pieceScaley - 0.2)
end

function Draggable:registerFunctions()
    self.boxCollider.onTouchDown = function() onTouchDown(self) end
    self.boxCollider.onTouchUp = function() onTouchUp(self) end
end

return Draggable