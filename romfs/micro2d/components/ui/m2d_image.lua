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
    Image:setImage(userParam)
    self.renderTask = RenderTask:new({
        layer = self.gameObject.transform:getPosition().z,
        execute = function () return self:render() end
    })
    return self
end

function Image:start() end
function Image:update() end

function Image:setCanvas(canvas)
    if self.canvas ~= nil then
        self.canvas:delElement(self)
    end
    
    self.canvas = canvas
    self.canvas:addElement(self)
    
    return self
end

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
    if not self.enabled then return end
        
    local position = self.gameObject.transform:getPosition()
    Graphics.drawImage(position.x, position.y, self.image)
end

return Image