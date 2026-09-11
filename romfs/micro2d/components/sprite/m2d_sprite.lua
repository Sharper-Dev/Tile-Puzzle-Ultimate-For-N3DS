--- A component that represents a sprite on the screen.
--- @module components_sprite
--- @author Sharper Dev

local Sprite = {}
Sprite.__index = Sprite

local RenderTask = require("renderer.m2d_render_task")
local Renderer = require("renderer.m2d_renderer")

--- The Sprite Constructor.
--- @param gameObject The game object this component is attached to.
function Sprite:new(gameObject)
    self = setmetatable({}, Sprite)

    self.enabled = true
    self.name = "Sprite"
    self.gameObject = gameObject
    self.imageWidth = 128
    self.imageHeight = 128
    self:setColor(255, 255, 255, nil)
    self.renderTask = RenderTask:new({
        layer = self.gameObject.transform.position.z,
        execute = function() return self:render() end
    })

    return self
end

--- Sets the screen for the sprite rendering.
--
--- @param screen The screen to set.
--- @return The sprite instance.
--- @usage sprite:setScreen(TOP_SCREEN) 
function Sprite:setScreen(screen)
    if self.screen == screen then return self end
    if self.screen ~= nil then
        Renderer.removeRenderTask(self.renderTask, self.screen, Renderer.SPACES.WORLD)
    end
    Renderer.addRenderTask(self.renderTask, screen, Renderer.SPACES.WORLD)
    self.screen = screen
    return self
end

--- Sets the color of the sprite.
--
--- @param r number red value
--- @param g number green value
--- @param b number blue value
--- @param a number alpha value (default: 255)
--- @return sprite The sprite instance.
--- @usage sprite:setColor(255, 0, 0)
function Sprite:setColor(r, g, b, a)
    if a == nil then a = 255 end
    self.color = Color.new(r, g, b, a)

    return self
end

--- Sets the sprite of the sprite component.
--
--- @param imgPath string The path to the sprite image.
--- @return sprite The sprite instance.
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
    Renderer.removeRenderTask(self.renderTask, self.screen, Renderer.SPACES.WORLD)
    self.gameObject = nil
    self.renderTask = nil
    self.enabled = nil
    self = nil
end

--- Render function containing the draw logic.
--
-- 
--- It is called automatically by the render task, in m2d_renderer.
function Sprite:render()
    if not self.enabled then return end

    local position = self.gameObject.transform.position
    self.renderTask.layer = position.z
    if self.sprite then
        Graphics.drawImageExtended(position.x, position.y, 0, 0, self.imageWidth, self.imageHeight,
            self.gameObject.transform.rotation,
            self.gameObject.transform.scale.x, self.gameObject.transform.scale.y, self.sprite, self.color)
    else
        Graphics.fillRect(position.x, position.x + self.imageWidth, position.y, position.y + self.imageHeight, self.color)
    end
end

return Sprite