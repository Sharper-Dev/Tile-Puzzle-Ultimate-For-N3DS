local SHCFonts = {}
local loadedFonts = {}
local FONTS_PATH = "romfs:/fonts/"

function SHCFonts.loadFont(fontName)
    local fontTable = {}
    fontTable.sheet = Graphics.loadImage(FONTS_PATH .. fontName .. "/" .. fontName .. ".png")
    fontTable.data = dofile(FONTS_PATH .. fontName .. "/" .. fontName .. ".lua")
    loadedFonts[fontName] = fontTable
end

function SHCFonts.getFont(fontName)
    return loadedFonts[fontName]
end

return SHCFonts
