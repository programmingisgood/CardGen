
local Deck = { }

local kToPercent = { }
kToPercent.min = 0
kToPercent.center = 0.5
kToPercent.max = 1

local function DrawContentBox(contentBox, xSize, ySize)

    local boxXSize = contentBox.xSize * xSize
    local boxYSize = contentBox.ySize * ySize
    
    local xAlignAmt = (kToPercent[contentBox.xAlign] or 0) * boxXSize
    local yAlignAmt = (kToPercent[contentBox.yAlign] or 0) * boxYSize
    love.graphics.translate(kToPercent[contentBox.xAnchor] * xSize - xAlignAmt,
                            kToPercent[contentBox.yAnchor] * ySize - yAlignAmt)
    
    love.graphics.setColor(0, 0, 0, 255)
    
    love.graphics.rectangle("line", 0, 0, boxXSize, boxYSize)
    
    love.graphics.print("test", 0, 0, 0)
    
end

local function SetContentBoxAlignment(contentBox, xAlign, yAlign)

    contentBox.xAlign = xAlign
    contentBox.yAlign = yAlign
    
end

local function AddContentBox(self, xAnchor, yAnchor, xSize, ySize)

    local contentBox = { xAnchor = xAnchor, yAnchor = yAnchor, xSize = xSize, ySize = ySize }
    contentBox.Draw = DrawContentBox
    contentBox.SetAlignment = SetContentBoxAlignment
    table.insert(self.contentBoxes, contentBox)
    
    return contentBox
    
end

local function Draw(self, xSize, ySize)

    love.graphics.setColor(0, 0, 0, 255)
    love.graphics.rectangle("line", 0, 0, xSize, ySize)
    
    for c = 1, #self.contentBoxes do
    
        love.graphics.push()
        self.contentBoxes[c]:Draw(xSize, ySize)
        love.graphics.pop()
        
    end
    
    love.graphics.reset()
    
end

Deck.Create = function(quantity)

    local deck = { quantity = 12, contentBoxes = { } }
    deck.AddContentBox = AddContentBox
    deck.Draw = Draw
    
    return deck
    
end

return Deck