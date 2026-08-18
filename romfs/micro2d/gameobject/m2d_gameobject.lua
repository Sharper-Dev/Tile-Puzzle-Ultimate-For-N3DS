--- The GameObject module.
--- @module gameobject
--- @author Sharper Dev

local GameObject = {}
GameObject.__index = GameObject

local Transform = require("components.transform.m2d_transform")
local ScenesManager = require("scenes.m2d_scenes_manager")

local componentsList = {
    ["Script"] = "components.script.m2d_script",
    ["Canvas"] = "components.ui.m2d_canvas",
    ["Image"] = "components.ui.m2d_image",
    ["Text"] = "components.ui.m2d_text",
    ["Sprite"] = "components.sprite.m2d_sprite",
}

--- The GameObject Constructor.
--- @param name The name of the GameObject.
--- @return The new GameObject.
--- @usage
--- local GameObject = require("gameobject.m2d_gameobject")
--- local obj = GameObject:new("MyObject")
function GameObject:new(name)
    self = setmetatable({}, GameObject)
    self.transform = Transform:new(self)
    self.enabled = true
    self.components = {}
    self.updateableComponents = {}
    self.name = name

    return self
end

--- Adds a component to the GameObject.
--- @param component The component to add.
--- @param userParam The user parameter for the component. (some params are optional)
--- @return The added component.
--- @usage
--- local obj = GameObject:new("MyObject")
--- obj:addComponent("Script")
function GameObject:addComponent(component, userParam)
    local comp = require(componentsList[component]):new(self, userParam)
    comp.gameObject = self
    table.insert(self.components, comp)
    if comp.update then
        table.insert(self.updateableComponents, comp)
    end
    return comp
end 

function GameObject:callUpdate()
    if not self.enabled then return end

	for i = 1, #self.updateableComponents do
		local component = self.updateableComponents[i]
		if component.enabled then
			component:update()
		end
	end
end

--- Instantiates a GameObject from a given path.
--- @param gameObjectPath The path to the GameObject file.
--- @return The instantiated GameObject.
--- @usage
--- local obj = GameObject.instantiate("path/to/GameObject.lua")
function GameObject.instantiate(gameObjectPath)
    local scene = ScenesManager.getActiveScenes()[1]
    local newObject
    
    if type(gameObjectPath) == "string" then
        newObject = scene:addGameObject(dofile(gameObjectPath))
        newObject.name = tostring(newObject)
    else
        newObject = scene:addGameObject(gameObjectPath)
    end
    
    for _, component in ipairs(newObject.components) do
        component:start()
    end

    return newObject
end

--- Finds a GameObject by its name.
--- @param name The name of the GameObject to find.
--- @return The found GameObject, or nil if not found.
--- @usage
--- local obj = GameObject.findByName("MyObject")
function GameObject.findByName(name)
    for _, object in ipairs(ScenesManager.getActiveScenes()[1].gameObjects) do
        if object.name == name then
            return object
        end
    end

    return nil
end

--- Destroys the GameObject.
--- Removes all components and destroys the GameObject.
function GameObject:destroy()
    for _, component in ipairs(self.components) do
        component:destroy()
    end

    self.scene.gameObjects[self.index] = nil
end

return GameObject