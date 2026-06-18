local SHCImage = {}
SHCImage.__index = SHCImage
local SHCTransform = require("sh_canvas.shc_transform")

function SHCImage:new(properties)
    local this = setmetatable({}, SHCImage)
    this.transform = properties.transform or SHCTransform:new()
    this.isVisible = properties.isVisible or true
    SHCImage.setImage(this, properties.imagePath)
    return this
end
function SHCImage:setImage(img)
    if type(img) == "string" then
        self.image = Graphics.loadImage(img)
    else
        self.image = img
    end 
    return self
end

function SHCImage:_drawGPU()
    if not self.isVisible then return end

    Graphics.drawImage(self.transform.position.x, self.transform.position.y, self.image)
end

return SHCImage
