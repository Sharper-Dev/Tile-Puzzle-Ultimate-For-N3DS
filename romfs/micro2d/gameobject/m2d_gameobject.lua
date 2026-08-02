--- The GameObject.
--- @module gameobject
--- @author Sharper Dev

local GameObject = {}
local componentsList = {
    ["Script"] = "components.script.m2d_script",
    --["Canvas"] = "components.ui.m2d_canvas",
    --["Image"] = "components.ui.m2d_image"
}
local SceneManager = require("scenes.m2d_scenes_manager")

function GameObject:new(name)
    local this = setmetatable({}, GameObject)
    this.transform = require("components.transform.m2d_transform"):new(this)
    this.components = {}
    this.name = name
    setmetatable(this, {__index = GameObject})
    return this
end

function GameObject.instantiate(gameObjectPath)
    local scene = SceneManager.getActiveScenes()[1]
    local newObject = scene:addGameObject(dofile(gameObjectPath))
    newObject.name = tostring(newObject)
    return newObject
end

function GameObject.findByName(name)
    for _, object in ipairs(SceneManager.getActiveScenes()[1].gameObjects) do
        if object.name == name then
            return object
        end
    end
    return nil
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

return GameObject