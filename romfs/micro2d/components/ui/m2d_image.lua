--- The UI Image component to display an image on the canvas.
--- @module components_ui_image
--- @author Sharper Dev

local Image = {}
Image.__index = Image

local RenderTask = require("renderer.m2d_render_task")

--- The Image Constructor.
--- @param gameObject The game object this component is attached to.
function Image:new(gameObject)
    self = setmetatable({}, Image)

    self.enabled = true
    self.name = "Image"
    self.gameObject = gameObject
    self:setColor(255, 255, 255, nil)
    self.pivot = 0
    self.renderTask = RenderTask:new({
        layer = self.gameObject.transform.position.z,
        execute = function() return self:render() end
    })

    return self
end

--- Sets the canvas to display the image on.
--- @param canvas table The canvas to set.
--- @return self image instance.
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
--- @param imgPath string The image path to load.
--- @return self image instance.
--- @usage
--- image:setImage(imgPath)
function Image:setImage(imgPath)
    if self.image ~= nil then
        Graphics.freeImage(self.image)
    end

    self.image = Graphics.loadImage(imgPath)
    self.imageWidth = Graphics.getImageWidth(self.image)
    self.imageHeight = Graphics.getImageHeight(self.image)
    return self
end

--- Sets the color of the image.
--- @param r number The red value.
--- @param g number The green value.
--- @param b number The blue value.
--- @param a number The alpha value.
--- @return self image instance.
--- @usage
--- image:setColor(r, g, b, a)
function Image:setColor(r, g, b, a)
    if a == nil then a = 255 end
	self.color = Color.new(r, g, b, a)

	return self
end

--- Destroys the image and removes it from the canvas.
--
-- 
--- It is called automatically when occurs a scene switch.
function Image:destroy()
    Graphics.freeImage(self.image)
    self.canvas:delElement(self)
    self.gameObject = nil
    self.renderTask = nil
    self.enabled = nil
    self = nil
end

--- Render function containing the draw logic.
--
-- 
--- It is called automatically by the render task, in m2d_renderer.
function Image:render()
    if not self.enabled then return end
    if not self.canvas.enabled then return end
    if self.image == nil then return end

    local position = self.gameObject.transform.position
    self.renderTask.layer = position.z
    local pivotX = self.imageWidth * self.pivot
    local pivotY = self.imageHeight * self.pivot

    Graphics.drawImageExtended(position.x + pivotX, position.y + pivotY, 0, 0, self.imageWidth, self.imageHeight,
        self.gameObject.transform.rotation,
        self.gameObject.transform.scale.x, self.gameObject.transform.scale.y, self.image, self.color)
end

return Image