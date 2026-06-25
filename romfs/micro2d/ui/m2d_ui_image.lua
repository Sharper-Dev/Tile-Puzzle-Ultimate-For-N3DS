--- The UI image.
--- @module ui_image
--- @author Sharper Dev

local Image = {}
Image.__index = Image
local UITransform = require("ui.m2d_ui_transform")

function Image:new(properties)
    local this = setmetatable({}, Image)
    this.transform = properties.transform or UITransform:new()
    this.isVisible = properties.isVisible or true
    Image:setImage(properties.imagePath)
    return this
end

function Image:setImage(img)
    if type(img) == "string" then
        self.image = Graphics.loadImage(img)
    else
        self.image = img
    end 
    return self
end

function Image:_drawGPU()
    if not self.isVisible then return end

    Graphics.drawImage(self.transform.position.x, self.transform.position.y, self.image)
end

return Image