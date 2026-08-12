--- A component that represents a sprite on the screen.
--- @module components_sprite
--- @author Sharper Dev

local Sprite = {}
Sprite.__index = Sprite

local RenderTask = require("renderer.m2d_render_task")
local Renderer = require("renderer.m2d_renderer")

--- The Sprite Constructor.
--- @param gameObject The game object this component is attached to.
--- @param userParam The sprite path to load.
function Sprite:new(gameObject, userParam)
    self = setmetatable({}, Sprite)
    
    self.enabled = true
    self.gameObject = gameObject
    self:setSprite(userParam) -- User parameter = image path
    self.renderTask = RenderTask:new({
        layer = self.gameObject.transform:getPosition().z,
        execute = function() return self:render() end
    })
    
    return self
end

function Sprite:start() end
function Sprite:update() end

function Sprite:setSpace(space)
    if self.space == space then return self end
    
    Renderer.delRenderTask(self.renderTask, self.space)
    Renderer.addRenderTask(self.renderTask, space)
    self.space = space
    return self
end

function Sprite:setSprite(imgPath)
    if self.sprite ~= nil then
        Graphics.freeImage(self.sprite)
    end
    
    self.sprite = Graphics.loadImage(imgPath)
    self.imageWidth = Graphics.getImageWidth(self.sprite)
    self.imageHeight = Graphics.getImageHeight(self.sprite)
    
    return self
end

--- Destroys the sprite component.
--
-- 
--- It is called automatically when occurs a scene switch.
function Sprite:destroy()
    Graphics.freeImage(self.sprite)
    self = nil
end

--- Render function containing the draw logic.
--
-- 
--- It is called automatically by the render task, in m2d_renderer.
function Sprite:render()
    if not self.enabled then return end

    local position = self.gameObject.transform:getPosition()
    Graphics.drawImageExtended(position.x, position.y, 0, 0, self.imageWidth, self.imageHeight,
        self.gameObject.transform.rotation,
        self.gameObject.transform.scale.x, self.gameObject.transform.scale.y, self.sprite)
end

return Sprite