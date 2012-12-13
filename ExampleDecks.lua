
local Deck = require("Deck")
local TextBox = require("TextBox")
local ImageBox = require("ImageBox")

local decks = { }

local function AddResource(typeName, r, g, b)

    local resourceFront = Deck.Create(12)
    
    local typeBox = resourceFront:AddContentBox("center", "min", 1, 0.15)
    typeBox:SetAlignment("center", "min")
    local textBox = typeBox:AddBox(TextBox.Create(string.upper(typeName), "center", "center", 20))
    textBox:SetAlignment("center", "center")
    textBox:SetColor(r, g, b, 255)
    
    local mainImageBox = resourceFront:AddContentBox("center", "center", 1, 0.70)
    mainImageBox:SetAlignment("center", "center")
    mainImageBox:AddBox(ImageBox.Create("card-art/" .. typeName .. ".png", "center", "center", 1, 1)):SetAlignment("center", "center")
    
    local resourceBack = Deck.Create(12)
    
    local mainImageBox = resourceBack:AddContentBox("center", "center", 1, 0.50)
    mainImageBox:SetAlignment("center", "center")
    mainImageBox:AddBox(ImageBox.Create("card-art/" .. typeName .. ".png", "center", "center", 1, 1)):SetAlignment("center", "center")
    
    table.insert(decks, resourceFront)
    table.insert(decks, resourceBack)
    
end

local function AddProperty(typeName, count)

    local propertyFront = Deck.Create(count)
    
    local typeBox = propertyFront:AddContentBox("center", "min", 1, 0.15)
    typeBox:SetAlignment("center", "min")
    local textBox = typeBox:AddBox(TextBox.Create(string.upper(typeName), "center", "center", 20))
    textBox:SetAlignment("center", "center")
    textBox:SetColor(0, 0, 0, 255)
    
    local mainImageBox = propertyFront:AddContentBox("center", "center", 1, 0.70)
    mainImageBox:SetAlignment("center", "center")
    mainImageBox:AddBox(ImageBox.Create("card-art/" .. typeName .. ".png", "center", "center", 1, 1)):SetAlignment("center", "center")
    
    local vpBox = propertyFront:AddContentBox("min", "min", 0.2, 0.2)
    vpBox:SetAlignment("min", "min")
    vpBox:AddBox(ImageBox.Create("card-art/vp.png", "center", "center", 1, 1)):SetAlignment("center", "center")
    vpBox:AddBox(TextBox.Create("0", "center", "center", 24)):SetAlignment("center", "center")
    
    local propertyBack = Deck.Create(count)
    
    local mainImageBox = propertyBack:AddContentBox("center", "center", 1, 0.70)
    mainImageBox:SetAlignment("center", "center")
    mainImageBox:AddBox(ImageBox.Create("card-art/" .. typeName .. ".png", "center", "center", 1, 1)):SetAlignment("center", "center")
    
    table.insert(decks, propertyFront)
    table.insert(decks, propertyBack)
    
end

AddResource("water", 0, 0, 255)
AddResource("tree", 0, 255, 0)

AddProperty("road", 12)

return decks