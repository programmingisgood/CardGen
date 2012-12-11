
local Utils = { }

local kToPercent = { }
kToPercent.min = 0
kToPercent.center = 0.5
kToPercent.max = 1

Utils.CalcTranslate = function(outerXSize, outerYSize, xSize, ySize, xAlign, yAlign, xAnchor, yAnchor)

    local boxXSize = xSize * outerXSize
    local boxYSize = ySize * outerYSize
    
    local xAlignAmt = (kToPercent[xAlign] or 0) * boxXSize
    local yAlignAmt = (kToPercent[yAlign] or 0) * boxYSize
    return kToPercent[xAnchor] * outerXSize - xAlignAmt,
           kToPercent[yAnchor] * outerYSize - yAlignAmt,
           boxXSize, boxYSize
    
end

Utils.SetBoxAlignment = function(box, xAlign, yAlign)

    box.xAlign = xAlign
    box.yAlign = yAlign
    
end

return Utils