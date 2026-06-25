local SHCText = {}
SHCText.__index = SHCText

local SHCFonts = require("sh_canvas.shc_fonts")
local SHCTransform = require("sh_canvas.shc_transform")
local utf8 = require("utf8")

function SHCText:new(properties)
    local this = setmetatable({}, SHCText)
    
    this.transform = properties.transform or SHCTransform:new()
    this.fontName = properties.fontName or "arial"
    this:setContent(properties.content or "")
    this.color = properties.color or Color.new(255, 255, 255)
    this.lineBreakDistance = properties.lineBreakDistance or 20
    return this
end

function SHCText:setContent(content)
    self.content = content
    self.contentLines = {}
    
    for line in content:gmatch("[^\r\n]+") do
        table.insert(self.contentLines, line)
    end
end

function SHCText:getContent()
    return self.content
end

function SHCText:_drawGPU()
    local cursor = { x = self.transform.position.x, y = self.transform.position.y }
    local font = SHCFonts.getFont(self.fontName)
    
    for _, lineContent in ipairs(self.contentLines) do
        for _, code in utf8.codes(lineContent) do
            local charInfo = font.data.chars[code]
            if charInfo then
                 Graphics.drawImageExtended(cursor.x + charInfo.xoffset, math.floor(cursor.y) + charInfo.yoffset * self.transform.scale.y, charInfo.x, charInfo.y, charInfo.width, charInfo.height,
                     self.transform.rotation, self.transform.scale.x, self.transform.scale.y, font.sheet)
                cursor.x = cursor.x + charInfo.xadvance * self.transform.scale.x
            end
        end
        cursor.y = cursor.y + self.lineBreakDistance
        cursor.x = self.transform.position.x
    end
end

return SHCText
