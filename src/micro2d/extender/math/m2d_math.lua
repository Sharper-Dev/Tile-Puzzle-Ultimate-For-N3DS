--- A math extender module for Micro2D.
--- @module extender_math
--- @author Sharper Dev

local MathE = {}

--- Lerp between two values.
--- @param a number
--- @param b number
--- @param t number
--- @return number
--- @usage local result = MathE.lerp(0, 100, 0.5) -- result is 50
function MathE.lerp(a, b, t)
    return a + (b - a) * t
end

--- Check if a point is inside an AABB.
--- @param rectX number
--- @param rectY number
--- @param rectW number
--- @param rectH number
--- @param pointX number
--- @param pointY number
--- @return boolean
--- @usage local inside = MathE.checkAABBPoint(0, 0, 100, 100, 50, 50) -- inside is true
function MathE.checkAABBPoint(rectX, rectY, rectW, rectH, pointX, pointY)
    return pointX >= rectX and pointX <= rectX + rectW and
               pointY >= rectY and pointY <= rectY + rectH
end

--- Check if two AABBs intersect.
--- @param rectX1 number
--- @param rectY1 number
--- @param rectW1 number
--- @param rectH1 number
--- @param rectX2 number
--- @param rectY2 number
--- @param rectW2 number
--- @param rectH2 number
--- @return boolean
--- @usage local intersects = MathE.checkAABBRect(0, 0, 100, 100, 50, 50, 100, 100) -- intersects is true
function MathE.checkAABBRect(rectX1, rectY1, rectW1, rectH1, rectX2, rectY2, rectW2, rectH2)
    return rectX1 <= rectX2 + rectW2 and
               rectX1 + rectW1 >= rectX2 and
               rectY1 <= rectY2 + rectH2 and
               rectY1 + rectH1 >= rectY2
end

return MathE