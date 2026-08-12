--- The UI Text component to display text on the canvas.
--- @module components_ui_text
--- @author Sharper Dev
local Text = {}
Text.__index = Text

local RenderTask = require("renderer.m2d_render_task")
local FontsManager = require("fonts.m2d_fonts_manager")
local utf8 = require("utf8")

--- The Text Constructor
--- @param gameObject The game object this component is attached to.
--- @param userParam The text content
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
    
--- Sets the canvas for this text component.
--- @param canvas The canvas to set.
--- @return The text component itself.
--- @usage myText:setCanvas(canvas)
function Text:setCanvas(canvas)
    if self.canvas ~= nil then
        self.canvas:delElement(self)
    end

    self.canvas = canvas
    self.canvas:addElement(self)

    return self
end

--- Sets the content of this text component.
--- @param content The content to set.
--- @usage myText:setContent("Hello, World!")
function Text:setContent(content)
    self.content = content
    self.contentLines = {}

    for line in content:gmatch("[^\r\n]+") do
        table.insert(self.contentLines, line)
    end
end

--- Returns the content of this text component.
--- @return The content of this text component.
--- @usage local content = myText:getContent()
function Text:getContent()
    return self.content
end

--- Sets the font of this text component.
--- @param fontID The font ID to set.
--- @usage myText:setFont("ComicSans")
function Text:setFont(fontID)
    self.fontID = fontID
end

--- Sets the line break distance of this text component.
--- @param value The line break distance to set.
--- @usage myText:setLineBreakDistance(10)
function Text:setLineBreakDistance(value)
    self.lineBreakDistance = value
end

--- Internal function to render the text.
function Text:render()
    if not self.enabled then return end
    local transform = self.gameObject.transform
    local position = transform:getPosition()
    local cursor = { x = position.x, y = position.y }
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
        cursor.x = position.x
    end
end

--- Destroys this text component.
function Text:destroy()
    self.canvas:delElement(self)
    self = nil
end

return Text