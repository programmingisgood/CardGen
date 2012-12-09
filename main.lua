
local example = "Hello!"

local canvas = nil

local Deck = require("Deck")

local decks = { }
decks.water = Deck.Create(12)
local typeBox = decks.water:AddContentBox("center", "min", 1, 0.15)
typeBox:SetAlignment("center", "min")
--local textBox = typeBox:AddTextBox("center", "center", 1, 1)
--textBox:SetText("WATER")

local function DrawDecks(decks)

    for _, deck in pairs(decks) do
        deck:Draw(200, 300)
    end
    
end

function love.load(args)

    love.filesystem.setIdentity("CardGen")
    example = args[2] or example
    
    local width = 600
    local height = 900
    love.graphics.setMode(width, height, false)
    
    canvas = love.graphics.newCanvas(width, height)
    canvas:clear(255, 255, 255, 255)
    canvas:renderTo(function() DrawDecks(decks) end)
    local imageData = canvas:getImageData()
    imageData:encode("card.bmp", "bmp")
    
end

function love.draw()

    love.graphics.draw(canvas, 0, 0)
    
    --love.event.push("quit")
    
end

function love.keypressed(k)

    if k == 'escape' then
        love.event.push("quit")
    end
    
end