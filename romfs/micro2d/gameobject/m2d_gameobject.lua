--- The GameObject.
--- @module gameobject
--- @author Sharper Dev

local GameObject = {}
GameObject.__index = GameObject

local Transform = require("components.transform.m2d_transform")

local componentsList = {
    ["Script"] = "components.script.m2d_script",
    --["Canvas"] = "components.ui.m2d_canvas",
    --["Image"] = "components.ui.m2d_image"
}
local ScenesManager = require("scenes.m2d_scenes_manager")

function GameObject:new(name)
    self = setmetatable({}, GameObject)
    self.transform = Transform:new(self)
    self.components = {}
    self.name = name
    
    return self
end

function GameObject:addComponent(component, params)
    local comp = require(componentsList[component]):new(params)
    table.insert(self.components, comp)
    
    return comp
end 

function GameObject:destroy()
    for _, component in ipairs(self.components) do
        component:destroy()
    end
    
    self.scene.gameObjects[self.index] = nil
end

function GameObject.instantiate(gameObjectPath)
    local scene = ScenesManager.getActiveScenes()[1]
    local newObject = scene:addGameObject(dofile(gameObjectPath))
    
    newObject.name = tostring(newObject)
    for _, component in ipairs(newObject.components) do
        component:start()
    end
    
    return newObject
end

function GameObject.findByName(name)
    for _, object in ipairs(ScenesManager.getActiveScenes()[1].gameObjects) do
        if object.name == name then
            return object
        end
    end
    
    return nil
end
return GameObject