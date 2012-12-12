
local example = "Hello!"

local canvas = nil

local Deck = require("Deck")
local TextBox = require("TextBox")
local ImageBox = require("ImageBox")

local decks = { }
decks.water = Deck.Create(8)

local typeBox = decks.water:AddContentBox("center", "min", 1, 0.15)
typeBox:SetAlignment("center", "min")
typeBox:AddBox(TextBox.Create("WATER", "center", "center", 20)):SetAlignment("center", "center")

local mainImageBox = decks.water:AddContentBox("center", "center", 1, 0.70)
mainImageBox:SetAlignment("center", "center")
mainImageBox:AddBox(ImageBox.Create("card-art/water.png", "center", "center", 1, 1)):SetAlignment("center", "center")

local function DrawDecks(decks, width, height)

    for _, deck in pairs(decks) do
        deck:Draw(width, height)
    end
    
end

local kA4PaperAspectRatio = 0.772
function love.load(args)

    love.filesystem.setIdentity("CardGen")
    example = args[2] or example
    
    local height = 900
    local width = height * kA4PaperAspectRatio
    love.graphics.setMode(width, height, false)
    
    canvas = love.graphics.newCanvas(width, height)
    canvas:clear(255, 255, 255, 255)
    canvas:renderTo(function() DrawDecks(decks, width, height) end)
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