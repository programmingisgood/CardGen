
local Utils = require("Utils")

local ContentBox = { }

local function DrawContentBox(contentBox, xSize, ySize)

    local x, y, boxXSize, boxYSize = Utils.CalcTranslate(xSize, ySize, contentBox.xSize, contentBox.ySize,
                                                         contentBox.xAlign, contentBox.yAlign,
                                                         contentBox.xAnchor, contentBox.yAnchor)
    love.graphics.translate(x, y)
    
    love.graphics.setColor(0, 0, 0, 255)
    
    love.graphics.rectangle("line", 0, 0, boxXSize, boxYSize)
    
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

ContentBox.Create = function(xAnchor, yAnchor, xSize, ySize)

    local contentBox = { xAnchor = xAnchor, yAnchor = yAnchor, xSize = xSize, ySize = ySize }
    contentBox.contents = { }
    contentBox.Draw = DrawContentBox
    contentBox.SetAlignment = Utils.SetBoxAlignment
    contentBox.AddBox = AddBox
    
    return contentBox
    
end

return ContentBox