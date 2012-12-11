
local ContentBox = require("ContentBox")

local Deck = { }

local function Draw(self, xSize, ySize)

    for c = 1, self.quantity do
    
        love.graphics.setColor(0, 0, 0, 255)
        love.graphics.rectangle("line", 0, 0, xSize, ySize)
        
        for b = 1, #self.contentBoxes do
        
            love.graphics.push()
            self.contentBoxes[b]:Draw(xSize, ySize)
            love.graphics.pop()
            
        end
        
        local x = xSize
        local y = 0
        if c % 3 == 0 then
        
            x = -xSize * 2
            y = ySize
            
        end
        love.graphics.translate(x, y)
        
    end
    
    love.graphics.reset()
    
end

local function AddContentBox(self, xAnchor, yAnchor, xSize, ySize)

    local contentBox = ContentBox.Create(xAnchor, yAnchor, xSize, ySize)
    table.insert(self.contentBoxes, contentBox)
    
    return contentBox
    
end

Deck.Create = function(quantity)

    local deck = { quantity = quantity, contentBoxes = { } }
    deck.AddContentBox = AddContentBox
    deck.Draw = Draw
    
    return deck
    
end

return Deck