--- Manages images for the Micro2D engine.
--
--- The ImagesBank stores loaded images and provides methods to load and unload them. Preventing duplicate loading of the same image.
--- @module bank_images
--- @author Sharper Dev

local ImagesBank = {}

local loadedImages = {}

--- Loads an image from the given path, caching it in the loadedImages table.
--- @param path string The path to the image file.
--- @return image_id The loaded image.
function ImagesBank.loadImage(path)
    if loadedImages[path] then
        return loadedImages[path]
    end
    loadedImages[path] = Graphics.loadImage(path)
    return loadedImages[path]
end

--- Unloads the image at the given path, freeing its resources.
--- @param path string The path to the image file.
function ImagesBank.unloadImage(path)
    if not loadedImages[path] then return end

    Graphics.freeImage(loadedImages[path])
    loadedImages[path] = nil
end

return ImagesBank