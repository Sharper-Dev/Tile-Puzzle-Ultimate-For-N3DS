--- The UI Image component to display an image on the canvas.
--- @module ui_image
--- @author Sharper Dev

local Image = {}
Image.__index = Image

local RenderTask = require("renderer.m2d_render_task")

--- The Image Constructor.
--- @param gameObject The game object this component is attached to.
--- @param userParam The image path to load.
function Image:new(gameObject, userParam)
    self = setmetatable({}, Image)
    
    self.enabled = true
    self.gameObject = gameObject
    self:setImage(userParam) -- User parameter = image path
    self.renderTask = RenderTask:new({
        layer = self.gameObject.transform:getPosition().z,
        execute = function() return self:render() end
    })
    
    return self
end

function Image:start() end
function Image:update() end

--- Sets the canvas to display the image on.
--- @param canvas The canvas to set.
--- @return The image instance.
--- @usage
--- image:setCanvas(canvas)
function Image:setCanvas(canvas)
    if self.canvas ~= nil then
        self.canvas:delElement(self)
    end

    self.canvas = canvas
    self.canvas:addElement(self)

    return self
end
--- Sets the image to display on the canvas.
--- @param imgPath The image path to load.
--- @return The image instance.
--- @usage
--- image:setImage(imgPath)
function Image:setImage(imgPath)
    if self.image ~= nil then
        Graphics.freeImage(self.image)
    end
    
    self.image = Graphics.loadImage(imgPath)

    return self
end

--- Destroys the image and removes it from the canvas.
--
-- 
--- It is called automatically when occurs a scene switch.
function Image:destroy()
    Graphics.freeImage(self.image)
    self.canvas:delElement(self)
    self = nil
end
--- Render function containing the draw logic.
--
-- 
--- It is called automatically by the render task, in m2d_renderer.
function Image:render()
    if not self.enabled then return end

    local position = self.gameObject.transform:getPosition()
    Graphics.drawImage(position.x, position.y, self.image)
end

return Image
