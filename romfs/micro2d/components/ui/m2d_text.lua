--- The UI Text component to display text on the canvas.
--- @module ui_text
--- @author Sharper Dev
local Text = {}
Text.__index = Text

local RenderTask = require("renderer.m2d_render_task")
local FontsManager = require("fonts.m2d_fonts_manager")
local utf8 = require("utf8")

function Text:new(gameObject, userParam)
    self = setmetatable({}, Text)

    self.enabled = true
    self.gameObject = gameObject
    self:setContent(userParam)
    self.color = Color.new(255, 255, 255)
    self.lineBreakDistance = 20
    self.renderTask = RenderTask:new({
        layer = self.gameObject.transform:getPosition().z,
        execute = function() return self:render() end
    })

    return self
end

function Text:start() end
function Text:update() end
    
function Text:setCanvas(canvas)
    if self.canvas ~= nil then
        self.canvas:delElement(self)
    end

    self.canvas = canvas
    self.canvas:addElement(self)

    return self
end

function Text:setContent(content)
    self.content = content
    self.contentLines = {}
    
    for line in content:gmatch("[^\r\n]+") do
        table.insert(self.contentLines, line)
    end
end

function Text:getContent()
    return self.content
end

function Text:setFont(fontID)
    self.fontID = fontID
end

function Text:setLineBreak(value)
    self.lineBreakDistance = value
end

function Text:render()
    if not self.enabled then return end
    local transform = self.gameObject.transform
    
    local cursor = { x = transform.position.x, y = transform.position.y }
    local font = FontsManager.getFont(self.fontID)

    for _, lineContent in ipairs(self.contentLines) do
        for _, code in utf8.codes(lineContent) do
            local charInfo = font.data.chars[code]
            if charInfo then
                Graphics.drawImageExtended(cursor.x + charInfo.xoffset,
                    math.floor(cursor.y) + charInfo.yoffset * transform.scale.y,
                    charInfo.x, charInfo.y, charInfo.width, charInfo.height,
                    transform.rotation, transform.scale.x, transform.scale.y, font.sheet)
                cursor.x = cursor.x + charInfo.xadvance * transform.scale.x
            end
        end
        cursor.y = cursor.y + self.lineBreakDistance
        cursor.x = transform.position.x
    end
end

function Text:destroy()
    self.canvas:delElement(self)
    self = nil
end

return Text