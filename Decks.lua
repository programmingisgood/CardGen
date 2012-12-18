
local Decks = { }

local function CreateNewCanvas(decks, width, height)

    local canvas = love.graphics.newCanvas(width, height)
    canvas:clear(255, 255, 255, 255)
    table.insert(decks.canvases, canvas)
    
    love.graphics.setCanvas()
    love.graphics.setCanvas(canvas)
    
    return canvas
    
end

local function RenderCanvasToFile(canvas, name)
    canvas:getImageData():encode(name .. ".bmp", "bmp")
end

local function DrawDecks(decks, scale)

    local pageWidth = decks.pageWidth * scale
    local pageHeight = decks.pageHeight * scale
    
    love.graphics.setMode(pageWidth, pageHeight, false)
    
    local canvas = CreateNewCanvas(decks, pageWidth, pageHeight)
    
    local cardXSize = decks.cardWidth * scale
    local cardYSize = decks.cardHeight * scale
    local totalCardsDrawn = 0
    
    for d = 1, #decks.decks do
    
        local deck = decks.decks[d]
        for c = 1, deck:GetNumCards() do
        
            if totalCardsDrawn > 0 then
            
                local x = cardXSize
                local y = 0
                if totalCardsDrawn % 3 == 0 then
                
                    x = -cardXSize * 2
                    y = cardYSize
                    
                end
                
                -- When a page is complete, create a new canvas.
                if totalCardsDrawn % 9 == 0 then
                
                    canvas = CreateNewCanvas(decks, pageWidth, pageHeight)
                    
                    x = -cardXSize * 2
                    y = -cardYSize * 2
                    
                end
                
                love.graphics.translate(x, y)
                
            end
            
            deck:DrawCard(c, cardXSize, cardYSize)
            
            totalCardsDrawn = totalCardsDrawn + 1
            
        end
        
    end
    
    love.graphics.setCanvas()
    
    for c = 1, #decks.canvases do
        RenderCanvasToFile(decks.canvases[c], c)
    end
    
end

-- These dimensions are in millimeters.
Decks.Create = function(pageWidth, pageHeight, cardWidth, cardHeight)

    local decks = { pageWidth = pageWidth, pageHeight = pageHeight, cardWidth = cardWidth, cardHeight = cardHeight, decks = { } }
    decks.canvases = { }
    decks.GetCanvases = function(self) return self.canvases end
    decks.Add = function(self, deck) table.insert(self.decks, deck) end
    decks.Draw = DrawDecks
    
    return decks
    
end

return Decks