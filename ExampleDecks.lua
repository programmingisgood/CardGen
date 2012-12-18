
local Decks = require("Decks")
local Deck = require("Deck")
local TextBox = require("TextBox")
local ImageBox = require("ImageBox")
local Utils = require("Utils")

local kFontName = "card-art/press-start-2p/PressStart2P.ttf"
local kFont2Name = "card-art/sourcesansproblack.ttf"

local decks = Decks.Create(216, 279, 63, 88)

local function AddTitleAndImage(toDeck, title, image, r, g, b)

    r = r or 0
    g = g or 0
    b = b or 0
    
    local typeBox = toDeck:AddContentBox("center", "min", 1, 0.15)
    typeBox:SetAlignment("center", "min")
    typeBox:SetOffset(0, 0.02)
    local textBox = typeBox:AddBox(TextBox.Create(title, "center", "center", 18))
    textBox:SetAlignment("center")
    textBox:SetColor(r, g, b, 255)
    textBox:SetFontName(kFontName)
    
    local mainImageBox = toDeck:AddContentBox("center", "center", 0.6, 0.6)
    mainImageBox:SetAlignment("center", "center")
    mainImageBox:AddBox(ImageBox.Create("card-art/" .. image, "center", "center", 1)):SetAlignment("center", "center")
    
end

local function AddVPBox(toDeck, vpAmounts)

    local vpBox = toDeck:AddContentBox("min", "min", 0.3, 0.3)
    vpBox:SetAlignment("min", "min")
    vpBox:SetOffset(0.02, 0.1)
    vpBox:AddBox(ImageBox.Create("card-art/vp.png", "center", "center", 1)):SetAlignment("center", "center")
    
    local vpBox2 = toDeck:AddContentBox("min", "min", 0.3, 0.3)
    vpBox2:SetAlignment("min", "min")
    vpBox2:SetOffset(0.02, 0.2)
    local vpText = vpBox2:AddBox(TextBox.Create(Utils.CreateCycleTextProvider(vpAmounts), "center", "center", 16))
    vpText:SetAlignment("center", "center")
    vpText:SetFontName(kFontName)
    
end

local function AddVP()

    local vpFront = Deck.Create(30)
    AddTitleAndImage(vpFront, "VP", "vp.png")
    
    local vpAmount = vpFront:AddContentBox("center", "center", 0.5, 0.5)
    vpAmount:SetAlignment("center", "center")
    vpAmount:SetOffset(0, 0.15)
    local textBox = vpAmount:AddBox(TextBox.Create(Utils.CreateCycleTextProvider({ 1, 2, 3 }), "center", "center", 20))
    textBox:SetColor(0, 0, 0, 255)
    textBox:SetFontName(kFontName)
    
    local vpBack = Deck.Create(30)
    AddTitleAndImage(vpBack, "VP", "vp.png")
    
    decks:Add(vpFront)
    decks:Add(vpBack)
    
end

local function AddPollution()

    local pollutionFront = Deck.Create(30)
    AddTitleAndImage(pollutionFront, "POLLUTION", "pollution.png")
    AddVPBox(pollutionFront, { -1, -2, -3 })
    
    local pollutionBack = Deck.Create(30)
    AddTitleAndImage(pollutionBack, "POLLUTION", "pollution.png")
    
    decks:Add(pollutionFront)
    decks:Add(pollutionBack)
    
end

local function AddResource(typeName, r, g, b)

    local resourceFront = Deck.Create(12)
    AddTitleAndImage(resourceFront, string.upper(typeName), typeName .. ".png", r, g, b)
    
    local quantityBox = resourceFront:AddContentBox("center", "max", 0.25, 0.25)
    quantityBox:SetAlignment("center", "max")
    
    local amounts = Utils.CreateCycleTextProvider({ "1x", "1x", "1x", "1x", "2x", "2x", "2x", "2x", "3x", "3x", "4x", "5x" })
    
    local textBox = quantityBox:AddBox(TextBox.Create(amounts, "center", "center", 30))
    textBox:SetAlignment("center", "min")
    textBox:SetColor(r, g, b, 255)
    textBox:SetFontName(kFontName)
    
    local resourceBack = Deck.Create(12)
    AddTitleAndImage(resourceBack, "RESOURCE", typeName .. ".png")
    
    decks:Add(resourceFront)
    decks:Add(resourceBack)
    
end

local function AddProperty(typeName, count, vpAmount, cost, effect)

    local propertyFront = Deck.Create(count)
    AddTitleAndImage(propertyFront, string.upper(typeName), typeName .. ".png")
    AddVPBox(propertyFront, { vpAmount })
    
    local costBox = propertyFront:AddContentBox("min", "min", 0.25, 0.25)
    costBox:SetAlignment("min", "min")
    costBox:SetOffset(0.02, 0.01)
    local textBox = costBox:AddBox(TextBox.Create(cost, "min", "min", 16))
    textBox:SetColor(0, 200, 0, 255)
    textBox:SetFontName(kFont2Name)
    
    local effectBox = propertyFront:AddContentBox("center", "max", 0.95, 0.35)
    effectBox:SetAlignment("center", "max")
    local textBox = effectBox:AddBox(TextBox.Create(effect, "center", "center", 12))
    textBox:SetColor(0, 50, 0, 255)
    textBox:SetFontName(kFont2Name)
    
    local propertyBack = Deck.Create(count)
    AddTitleAndImage(propertyBack, "PROPERTY", typeName .. ".png")
    
    decks:Add(propertyFront)
    decks:Add(propertyBack)
    
end

AddVP()
AddPollution()

AddResource("water", 0, 0, 255)
AddResource("tree", 0, 200, 0)
AddResource("coal", 0, 0, 0)
AddResource("stone", 127, 127, 127)
AddResource("grain", 180, 130, 0)

local roadEffect = "Creates 2 build sites. No build site requirement for a road. Draw and play 1 pollution card upon purchase."
AddProperty("road", 12, 1, "1T, 1S", roadEffect)

local bakeryEffect = "At the end of your turn, discard 3 Water and 3 Grain and draw 2 VP cards. Draw and play 1 pollution card."
AddProperty("bakery", 5, 0, "2T, 1S", bakeryEffect)

local refineryEffect = "At the end of your turn, place 1 coal card under the Refinery and then draw and play 1 pollution card. When used in later turns, the quantity value of these cards is doubled."
AddProperty("refinery", 5, 2, "2C, 3S 1T", refineryEffect)

local powerEffect = "At the end of your turn, discard up to 3 coal cards. Draw a VP card per coal card discarded. Draw and play 3 pollution cards."
AddProperty("power", 5, 3, "5C, 4S, 2T", powerEffect)

local paperEffect = "At the end of your turn, discard 1 Water and 1 Tree card. Draw VP cards equal to the quantity value of both discarded cards divided by 3 (rounded down)."
AddProperty("paper", 5, 1, "2T, 2S", paperEffect)

local damEffect = "At the end of your turn, remove 1 pollution card from your hand and play this same pollution card."
AddProperty("dam", 5, 0, "2T, 2W", damEffect)

local sawmillEffect = "At the end of your turn, discard 1 Tree card. Draw 1 VP card. Draw and play 1 pollution card."
AddProperty("sawmill", 5, 3, "4T, 2S", sawmillEffect)

local farmEffect = "At the end of your turn you must draw and play 1 pollution card. At the end of the game, score 1 VP per property card you own."
AddProperty("farm", 5, 0, "2T, 5G, 1W", farmEffect)

AddProperty("monument", 1, 10, "10S", "Does nothing.")

return decks