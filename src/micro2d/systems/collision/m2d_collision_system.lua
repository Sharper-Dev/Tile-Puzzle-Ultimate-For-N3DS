--- Manages collisions between objects in the game.
--- @module systems_collision
--- @author Sharper Dev

local MathE = require("extender.math.m2d_math")
local InputSystem = require("systems.input.m2d_input_system")

local CollisionSystem = {}

local collisionLayers = {}

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

local function processColliders(boxCollider1, boxCollider2)
    if boxCollider1 == boxCollider2 then return end

    for i = 1, #boxCollider1.ignoreMetaLayers do
        if boxCollider1.ignoreMetaLayers[i] == boxCollider2.metaCollisionLayer then
            return
        end
    end
    local colliderPositionx1 = boxCollider1.gameObject.transform.position.x
    local colliderPositiony1 = boxCollider1.gameObject.transform.position.y
    colliderPositionx1 = colliderPositionx1 + boxCollider1.xoffset
    colliderPositiony1 = colliderPositiony1 + boxCollider1.yoffset

    local colliderPositionx2 = boxCollider2.gameObject.transform.position.x
    local colliderPositiony2 = boxCollider2.gameObject.transform.position.y
    colliderPositionx2 = colliderPositionx2 + boxCollider2.xoffset
    colliderPositiony2 = colliderPositiony2 + boxCollider2.yoffset

    local isColliding = MathE.checkAABBRect(colliderPositionx1, colliderPositiony1, boxCollider1.width, boxCollider1.height,
        colliderPositionx2, colliderPositiony2, boxCollider2.width, boxCollider2.height)

    if isColliding then
        if not boxCollider1.enteredCollisions[boxCollider2] then
            boxCollider1:onCollisionEnter(boxCollider2)
            boxCollider1.enteredCollisions[boxCollider2] = true
        end

        if not boxCollider2.enteredCollisions[boxCollider1] then
            boxCollider2:onCollisionEnter(boxCollider1)
            boxCollider2.enteredCollisions[boxCollider1] = true
        end

        if boxCollider1.enteredCollisions[boxCollider2] then
            boxCollider1:onCollisionStay(boxCollider2)
        end

        if boxCollider2.enteredCollisions[boxCollider1] then
            boxCollider2:onCollisionStay(boxCollider1)
        end
    else
        if boxCollider1.enteredCollisions[boxCollider2] then
            boxCollider1:onCollisionExit(boxCollider2)
            boxCollider1.enteredCollisions[boxCollider2] = false
        end

        if boxCollider2.enteredCollisions[boxCollider1] then
            boxCollider2:onCollisionExit(boxCollider1)
            boxCollider2.enteredCollisions[boxCollider1] = false
        end
    end
end

function CollisionSystem.registerCollider(layer, boxCollider)
    collisionLayers[layer] = collisionLayers[layer] or {}
    collisionLayers[layer][tostring(boxCollider)] = boxCollider
end

function CollisionSystem.unregisterCollider(layer, boxCollider)
    collisionLayers[layer][tostring(boxCollider)] = nil
end

function CollisionSystem.processCollisions()
	for i = 1, #collisionLayers do
		local layer = collisionLayers[i]
		for _, boxCollider in pairs(layer) do
            processTouch(boxCollider)
            for _, boxCollider2 in pairs(layer) do
                processColliders(boxCollider, boxCollider2)
            end
		end
	end
end

return CollisionSystem