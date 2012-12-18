
local Utils = require("Utils")

local ContentBox = { }

local function DrawContentBox(contentBox, xSize, ySize)

    local x, y, boxXSize, boxYSize = Utils.CalcTranslate(xSize, ySize, contentBox.xSize, contentBox.ySize,
                                                         contentBox.xAlign, contentBox.yAlign,
                                                         contentBox.xAnchor, contentBox.yAnchor)
    local xOff = (contentBox.xOff or 0) * xSize
    local yOff = (contentBox.yOff or 0) * ySize
    love.graphics.translate(x + xOff, y + yOff)
    
    love.graphics.setColor(0, 0, 0, 255)
    
    --love.graphics.rectangle("line", 0, 0, boxXSize, boxYSize)
    
    for c = 1, #contentBox.contents do
    
        love.graphics.push()
        contentBox.contents[c]:Draw(boxXSize, boxYSize)
        love.graphics.pop()
        
    end
    
end

local function AddBox(contentBox, addBox)

    table.insert(contentBox.contents, addBox)
    return addBox
    
end

local function SetOffset(contentBox, xOff, yOff)

    contentBox.xOff = xOff
    contentBox.yOff = yOff
    
end

ContentBox.Create = function(xAnchor, yAnchor, xSize, ySize)

    local contentBox = { xAnchor = xAnchor, yAnchor = yAnchor, xSize = xSize, ySize = ySize }
    contentBox.contents = { }
    contentBox.Draw = DrawContentBox
    contentBox.SetAlignment = Utils.SetBoxAlignment
    contentBox.AddBox = AddBox
    contentBox.SetOffset = SetOffset
    
    return contentBox
    
end

return ContentBox