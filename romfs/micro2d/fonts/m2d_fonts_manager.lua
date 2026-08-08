local FontsManager = {}
local loadedFonts = {}

function FontsManager.loadFont(id, fontPath)
    local fontName = fontPath:match("[^/]+$")
    
    loadedFonts[id] = {
        data = dofile(fontPath .. "/" .. fontName .. ".lua"),
        sheet = Graphics.loadImage(fontPath .. "/" .. fontName .. ".png")
    }

    return loadedFonts[id]
end

function FontsManager.unloadFont(id)
    Graphics.freeImage(loadedFonts[id].sheet)
    loadedFonts[id] = nil
end

function FontsManager.getFont(id)
    return loadedFonts[id]
end

return FontsManager