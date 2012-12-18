
local Utils = require("Utils")

local TextBox = { }

local kFonts = { default = { } }

local kAlignToAlignMode = { min = "left", center = "center", max = "right" }

local function DrawTextBox(textBox, xSize, ySize)

    local fontName = textBox.fontName or "default"
    kFonts[fontName] = kFonts[fontName] or { }
    local useFont = kFonts[fontName][textBox.fontSize]
    if not useFont then
    
        if fontName == "default" then
            kFonts[fontName][textBox.fontSize] = love.graphics.newFont(textBox.fontSize)
        else
            kFonts[fontName][textBox.fontSize] = love.graphics.newFont(fontName, textBox.fontSize)
        end
        useFont = kFonts[fontName][textBox.fontSize]
        
    end
    love.graphics.setFont(useFont)
    
    local useText = textBox.text
    if type(useText) == "function" then
        useText = useText()
    end
    
    --local textWidth = useFont:getWidth(useText)
    --local textHeight = useFont:getHeight(useText)
    
    --local x, y, boxXSize, boxYSize = Utils.CalcTranslate(xSize, ySize, textWidth / xSize, textHeight / ySize,
    --                                                     textBox.xAlign, textBox.yAlign,
    --                                                     textBox.xAnchor, textBox.yAnchor)
    
    --love.graphics.translate(x, y)
    
    love.graphics.setColor(textBox.red or 0, textBox.green or 0, textBox.blue or 0, textBox.alpha or 255)
    love.graphics.printf(useText, 0, 0, xSize, kAlignToAlignMode[textBox.xAnchor])
    
    --love.graphics.rectangle("line", 0, 0, xSize, ySize)
    
end

local function SetFontName(textBox, fontName)
    textBox.fontName = fontName
end

TextBox.Create = function(text, xAnchor, yAnchor, size)

    local textBox = { text = text, xAnchor = xAnchor, yAnchor = yAnchor, fontSize = size }
    textBox.SetAlignment = Utils.SetBoxAlignment
    textBox.SetColor = Utils.SetColor
    textBox.SetFontName = SetFontName
    textBox.Draw = DrawTextBox
    
    return textBox
    
end

return TextBox