--- The UI image.
--- @module ui_image
--- @author Sharper Dev

local Image = {}
Image.__index = Image
local RenderTask = require("renderer.m2d_render_task")

-- User parameter = image path
function Image:new(gameObject, userParam)
    self = setmetatable({}, Image)
    self.enabled = true
    self.gameObject = gameObject
    if self.gameObject.canvas == nil then
        error("gameObject must have a canvas")
    end
    self.canvas = self.gameObject.canvas
    Image:setImage(userParam)
    self.renderTask = RenderTask:new({
        enabled = self.enabled,
        layer = self.gameObject.transform:getPosition().z,
        execute = function () return self:render() end
    })
    
    self.canvas:addElement(self)
    return self
end

function Image:start() end
function Image:update() end
    
function Image:setImage(img)
    if type(img) == "string" then
        self.image = Graphics.loadImage(img)
    else
        self.image = img
    end 
    return self
end

function Image:destroy()
    Graphics.freeImage(self.image)
    self.canvas:delElement(self)
	self = nil
end

function Image:render()
    local position = self.gameObject.transform:getPosition()
    Graphics.drawImage(position.x, position.y, self.image)
end

return Image