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
    self:setColor(255, 255, 255)
    self.renderTask = RenderTask:new({
        layer = self.gameObject.transform.position.z,
        execute = function() return self:render() end
    })
    
    return self
end

function Sprite:start() end
function Sprite:update() end

function Sprite:setScreen(screen)
    if self.screen == screen then return self end
    if self.screen ~= nil then
        Renderer.removeRenderTask(self.renderTask, self.screen, Renderer.SPACES.WORLD)
    end
    Renderer.addRenderTask(self.renderTask, screen, Renderer.SPACES.WORLD)
    self.screen = screen
    return self
end

function Sprite:setColor(r, g, b, a)
    if a == nil then a = 255 end
	self.color = Color.new(r, g, b, a)

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

    local position = self.gameObject.transform.position
    self.renderTask.layer = position.z
    Graphics.drawImageExtended(position.x, position.y, 0, 0, self.imageWidth, self.imageHeight,
        self.gameObject.transform.rotation,
        self.gameObject.transform.scale.x, self.gameObject.transform.scale.y, self.sprite, self.color)
end

return Sprite