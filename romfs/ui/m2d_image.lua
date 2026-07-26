--- The UI image.
--- @module ui_image
--- @author Sharper Dev

local Image = {}
Image.__index = Image
local RenderTask = require("renderer.m2d_render_task")

function Image:new(params)
    local this = setmetatable({}, Image)
    this.enabled = (params.enabled == nil) and true or params.enabled
    if params.gameObject == nil then
        error("gameObject is required")
    end
    this.gameObject = params.gameObject
    
    this.task = RenderTask:new({
        layer = this.gameObject.transform.position.z,
        execute = this.render
    })
    Image:setImage(params.imagePath)
    return this
end

function Image:setImage(img)
    if type(img) == "string" then
        self.image = Graphics.loadImage(img)
    else
        self.image = img
    end 
    return self
end

function Image:destroy()
    Graphics.freeImage(self.image)
	self = nil
end

function Image:render()
    if not self.enabled then return end

    Graphics.drawImage(self.gameObject.transform.position.x, self.gameObject.transform.position.y, self.image)
end

return Image