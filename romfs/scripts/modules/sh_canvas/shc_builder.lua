local SHCBuilder = {}

local SHCText = require("sh_canvas.shc_text")
local SHCTransform = require("sh_canvas.shc_transform")
local SHCImage = require("sh_canvas.shc_image")

function SHCBuilder.createText(canvas, fontName, size, x, y, z, content)
    local text = SHCText:new({
        transform = SHCTransform:new():setPosition(x, y, z),
        fontName = fontName,
        content = content
    })
    text.transform:setScale(size, size)
    text.canvas = canvas
    canvas:addCanvasComponent(text)
    return text
end

function SHCBuilder.createImage(canvas, imagePath, x, y, z)
    local image = SHCImage:new({
        transform = SHCTransform:new():setPosition(x, y, z),
        imagePath = imagePath
    })
    
    canvas:addCanvasComponent(image)
    return image
end
return SHCBuilder