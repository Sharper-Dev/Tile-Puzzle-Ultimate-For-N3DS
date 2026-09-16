--- Manages collisions between objects in the game.
--- @module collision_engine
--- @author Sharper Dev

local MathE = require("extender.math.m2d_math")
local InputSystem = require("input.m2d_input_system")

local CollisionEngine = {}

local collisionLayers = {}

function CollisionEngine.insertCollider(layer, boxCollider)
    collisionLayers[layer] = collisionLayers[layer] or {}
    collisionLayers[layer][tostring(boxCollider)] = boxCollider
end

function CollisionEngine.removeCollider(layer, boxCollider)
    collisionLayers[layer][tostring(boxCollider)] = nil
end
local function processTouch(boxCollider)
    if not boxCollider.enabled then return end

    local colliderPositionx = boxCollider.gameObject.transform.position.x
    local colliderPositiony = boxCollider.gameObject.transform.position.y
    colliderPositionx = colliderPositionx + boxCollider.xoffset
    colliderPositiony = colliderPositiony + boxCollider.yoffset

    if InputSystem.getKey(KEY_TOUCH) then
        local x, y = InputSystem.getTouch()
        local isInside = MathE.checkAABBPoint(colliderPositionx, colliderPositiony, boxCollider.width,
            boxCollider.height, x, y)
        if isInside and InputSystem.getKeyDown(KEY_TOUCH) then
            boxCollider:onTouchDown()
            boxCollider.hasTouch = true
        end
        if isInside and boxCollider.hasTouch then
            boxCollider:onTouchStay()
        end
    else
        if boxCollider.hasTouch then
            boxCollider:onTouchUp()
            boxCollider.hasTouch = false
        end
    end
end

function CollisionEngine.processCollisions()
	for i = 1, #collisionLayers do
		local layer = collisionLayers[i]
		for _, boxCollider in pairs(layer) do
            processTouch(boxCollider)
		end
	end
end

return CollisionEngine