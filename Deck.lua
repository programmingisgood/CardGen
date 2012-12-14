
local ContentBox = require("ContentBox")

local Deck = { }

local function AddContentBox(self, xAnchor, yAnchor, xSize, ySize)

    local contentBox = ContentBox.Create(xAnchor, yAnchor, xSize, ySize)
    table.insert(self.contentBoxes, contentBox)
    
    return contentBox
    
end

local function DrawCard(self, cardIndex, xSize, ySize)

    love.graphics.setLineStyle("rough")
    
    love.graphics.setColor(0, 0, 0, 255)
    love.graphics.rectangle("line", 1, 0, xSize - 1, ySize - 1)
    
    for b = 1, #self.contentBoxes do
    
        love.graphics.push()
        self.contentBoxes[b]:Draw(xSize, ySize)
        love.graphics.pop()
        
    end
    
end

Deck.Create = function(quantity)

    local deck = { quantity = quantity, contentBoxes = { } }
    function deck:GetNumCards() return self.quantity end
    deck.AddContentBox = AddContentBox
    deck.DrawCard = DrawCard
    
    return deck
    
end

return Deck