local MathE = {}

function MathE.lerp(a, b, t)
    return a + (b - a) * t
end

function MathE.checkAABBPoint(rectX, rectY, rectW, rectH, pointX, pointY)
    return pointX >= rectX and pointX <= rectX + rectW and
               pointY >= rectY and pointY <= rectY + rectH
end

function MathE.checkAABBRect(rectX1, rectY1, rectW1, rectH1, rectX2, rectY2, rectW2, rectH2)
    return rectX1 <= rectX2 + rectW2 and
               rectX1 + rectW1 >= rectX2 and
               rectY1 <= rectY2 + rectH2 and
               rectY1 + rectH1 >= rectY2
end

return MathE