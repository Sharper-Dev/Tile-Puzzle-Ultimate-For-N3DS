--- A component that makes an object draggable.
--- @module components_draggable
--- @author Sharper Dev

local Draggable = {}
Draggable.__index = Draggable

function Draggable:new(gameObject)
    self = setmetatable({}, Draggable)

    self.enabled = true
    self.name = "Draggable"
    self.gameObject = gameObject

    return self
end

return Draggable