
local canvases = { }

local function CreateNewCanvas(width, height)

    local canvas = love.graphics.newCanvas(width, height)
    canvas:clear(255, 255, 255, 255)
    table.insert(canvases, canvas)
    
    love.graphics.setCanvas()
    love.graphics.setCanvas(canvas)
    
    return canvas
    
end

local function RenderCanvasToFile(canvas, name)
    canvas:getImageData():encode(name .. ".bmp", "bmp")
end

local function DrawDecks(decks, width, height)

    local canvas = CreateNewCanvas(width, height)
    
    local cardXSize = width / 3
    local cardYSize = height / 3
    local totalCardsDrawn = 0
    
    for d = 1, #decks do
    
        local deck = decks[d]
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
                
                    canvas = CreateNewCanvas(width, height)
                    
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
    
    for c = 1, #canvases do
        RenderCanvasToFile(canvases[c], c)
    end
    
end

local kA4PaperAspectRatio = 0.772
local pageHeight = 1000
local pageWidth = pageHeight * kA4PaperAspectRatio
function love.load(args)

    love.filesystem.setIdentity("CardGen")
    if args[2] then
    
        local decks = require(args[2])
        
        love.graphics.setMode(pageWidth, pageHeight, false)
        
        DrawDecks(decks, pageWidth, pageHeight)
        
    end
    
end

local currentCanvas = 1
function love.draw()

    love.graphics.reset()
    
    love.graphics.draw(canvases[currentCanvas], 0, 0)
    
    --love.event.push("quit")
    
end

function love.keypressed(k)

    if k == "escape" then
        love.event.push("quit")
    elseif k == "left" then
        currentCanvas = currentCanvas > 1 and (currentCanvas - 1) or 1
    elseif k == "right" then
        currentCanvas = currentCanvas < #canvases and (currentCanvas + 1) or #canvases
    end
    
end