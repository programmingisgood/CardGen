
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

Utils.SetColor = function(item, red, green, blue, alpha)

    item.red = red
    item.green = green
    item.blue = blue
    item.alpha = alpha
    
end

Utils.CreateCycleTextProvider = function(cycleItems)

    local cycleNum = 1
    return function()

        if cycleNum > #cycleItems then cycleNum = 1 end
        local retItem = tostring(cycleItems[cycleNum])
        cycleNum = cycleNum + 1
        return retItem
        
    end
    
end

return Utils