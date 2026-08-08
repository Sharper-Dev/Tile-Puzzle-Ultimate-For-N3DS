--- Manages fonts for the Micro2D engine.
--- The Fonts Manager works with Bitmap Fonts, previously converted to Lua table and a PNG sheet.
--
--- You can use my own tool called [BMFont2Lua](https://github.com/Sharper-Dev/BMFont2Lua) to convert your own BMFonts JSON files to Lua table.
--- @module fonts_manager
--- @author Sharper Dev
--- 
local FontsManager = {}
local loadedFonts = {}

--- Loads a font from the given path and associates it with the given ID.
--
--- The font is stored in memory and can be retrieved using `FontsManager.getFont(id)`.
--- @param id string The ID to associate the font with.
--- @param fontPath string The path to the font files. The font name should be the last part of the path, and the files should be named `<fontName>.lua` and `<fontName>.png`.
--- @return table The loaded font data.
--- @usage local myFont = FontsManager.loadFont("myFont", "romfs/micro2d/fonts/myFont")
function FontsManager.loadFont(id, fontPath)
    local fontName = fontPath:match("[^/]+$")

    loadedFonts[id] = {
        data = dofile(fontPath .. "/" .. fontName .. ".lua"),
        sheet = Graphics.loadImage(fontPath .. "/" .. fontName .. ".png")
    }

    return loadedFonts[id]
end

--- Unloads the font associated with the given ID, freeing its resources.
--- @param id string The ID of the font to unload.
--- @usage FontsManager.unloadFont("myFont")
function FontsManager.unloadFont(id)
    Graphics.freeImage(loadedFonts[id].sheet)
    loadedFonts[id] = nil
end

--- Returns the font associated with the given ID.
--- @param id string The ID of the font to retrieve.
--- @return table The font data.
--- @usage local myFont = FontsManager.getFont("myFont")
function FontsManager.getFont(id)
    return loadedFonts[id]
end

return FontsManager