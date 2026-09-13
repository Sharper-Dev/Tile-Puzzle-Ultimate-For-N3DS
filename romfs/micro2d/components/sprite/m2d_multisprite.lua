local Sprite = require("components.sprite.m2d_sprite")
local RenderTask = require("renderer.m2d_render_task")

local MultiSprite = {}
setmetatable(MultiSprite, { __index = Sprite })
MultiSprite.__index = MultiSprite

function MultiSprite:new(gameObject)
    self = Sprite.new(self, gameObject)
    setmetatable(self, MultiSprite)
    self.name = "MultiSprite"
    self.cellSize = { x = 16, y = 16 }
    self.cellCursor = { x = 0, y = 0 }
    return self
end

function MultiSprite:render()
    if not self.enabled then return end

    local position = self.gameObject.transform.position
    self.renderTask.layer = position.z
    local cellX = self.cellCursor.x * self.cellSize.x
    local cellY = self.cellCursor.y * self.cellSize.y

    if self.sprite then
        Graphics.drawImageExtended(position.x, position.y, cellX, cellY, self.cellSize.x, self.cellSize.y,
            self.gameObject.transform.rotation,
            self.gameObject.transform.scale.x, self.gameObject.transform.scale.y, self.sprite, self.color)
    else
        Graphics.fillRect(position.x, position.x + self.imageWidth, position.y, position.y + self.imageHeight, self
        .color)
    end
end

return MultiSprite