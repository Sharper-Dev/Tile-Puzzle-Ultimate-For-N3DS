local ImagesBank = {}
--- Manages images for the Micro2D engine.
--- 
--- @module bank_images
--- @author Sharper Dev

local loadedImages = {}

function ImagesBank.loadImage(path)
    if loadedImages[path] then
        return loadedImages[path]
    end
    loadedImages[path] = Graphics.loadImage(path)
    return loadedImages[path]
end

function ImagesBank.unloadImage(path)
    if not loadedImages[path] then return end

    Graphics.freeImage(loadedImages[path])
    loadedImages[path] = nil
end

return ImagesBank