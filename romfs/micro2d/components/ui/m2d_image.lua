--- The UI image.
--- @module ui_image
--- @author Sharper Dev

local Image = {}
Image.__index = Image

function Image:new(properties)
    local this = setmetatable({}, Image)
    this.isVisible = properties.isVisible or true
    if properties.gameObject == nil then
        error("gameObject is required")
    end
    this.gameObject = properties.gameObject
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

    Graphics.drawImage(self.gameObject.transform.position.x, self.gameObject.transform.position.y, self.image)
end

return Image