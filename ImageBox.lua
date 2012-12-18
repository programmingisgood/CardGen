
local Utils = require("Utils")

local ImageBox = { }

local kImages = { }

local function DrawImageBox(imageBox, xSize, ySize)

    local x, y, boxXSize, boxYSize = Utils.CalcTranslate(xSize, ySize, imageBox.scale, imageBox.scale,
                                                         imageBox.xAlign, imageBox.yAlign,
                                                         imageBox.xAnchor, imageBox.yAnchor)
    love.graphics.translate(x, y)
    
    love.graphics.setColor(255, 255, 255, 255)
    local imageWidth = imageBox.image:getWidth()
    local imageHeight = imageBox.image:getHeight()
    
    local parentSize = ySize
    if xSize < ySize then
        parentSize = xSize
    end
    love.graphics.draw(imageBox.image, 0, 0, 0, parentSize / imageWidth * imageBox.scale,
                       parentSize / imageHeight * imageBox.scale)
    
    --love.graphics.setColor(0, 0, 0, 255)
    --love.graphics.rectangle("line", 0, 0, boxXSize, boxYSize)
    
end

ImageBox.Create = function(fileName, xAnchor, yAnchor, scale)

    if not kImages[fileName] then
    
        kImages[fileName] = love.graphics.newImage(fileName)
        kImages[fileName]:setFilter("nearest", "nearest")
        
    end
    
    local imageBox = { image = kImages[fileName], xAnchor = xAnchor, yAnchor = yAnchor, scale = scale }
    imageBox.SetAlignment = Utils.SetBoxAlignment
    imageBox.Draw = DrawImageBox
    
    return imageBox
    
end

return ImageBox