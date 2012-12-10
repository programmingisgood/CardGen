
local ContentBox = require("ContentBox")

local Deck = { }

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

local function AddContentBox(self, xAnchor, yAnchor, xSize, ySize)

    local contentBox = ContentBox.Create(xAnchor, yAnchor, xSize, ySize)
    table.insert(self.contentBoxes, contentBox)
    
    return contentBox
    
end

Deck.Create = function(quantity)

    local deck = { quantity = 12, contentBoxes = { } }
    deck.AddContentBox = AddContentBox
    deck.Draw = Draw
    
    return deck
    
end

return Deck