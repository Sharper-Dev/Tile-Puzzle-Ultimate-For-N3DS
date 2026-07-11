local Scene = require("scenes.m2d_scenes_scene")
local GameObject = require("gameobject.m2d_gameobject")
local SampleScene = Scene:new()
local gameObject = GameObject:new()
local gameObject2 = GameObject:new()

function gameObject.behaviour:update()
    Graphics.initBlend(TOP_SCREEN)
    Graphics.fillRect(0,100,0,10,Color.new(255,255,255))
    Graphics.termBlend()
end

function gameObject2.behaviour:update()
    Graphics.initBlend(BOTTOM_SCREEN)
    Graphics.fillRect(0,10,0,10,Color.new(255,255,255))
    Graphics.termBlend()
end

SampleScene:addGameObject(gameObject)
SampleScene:addGameObject(gameObject2)
return SampleScene