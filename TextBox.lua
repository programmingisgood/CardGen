
local Utils = require("Utils")

local TextBox = { }

local kFonts = { default = { } }

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
    
    local textWidth = useFont:getWidth(textBox.text)
    local textHeight = useFont:getHeight(textBox.text)
    
    local x, y, boxXSize, boxYSize = Utils.CalcTranslate(xSize, ySize, textWidth / xSize, textHeight / ySize,
                                                         textBox.xAlign, textBox.yAlign,
                                                         textBox.xAnchor, textBox.yAnchor)
    love.graphics.translate(x, y)
    
    love.graphics.setColor(textBox.red or 0, textBox.green or 0, textBox.blue or 0, textBox.alpha or 255)
    love.graphics.print(textBox.text, 0, 0)
    
    --love.graphics.rectangle("line", 0, 0, boxXSize, boxYSize)
    
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