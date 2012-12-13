
local Utils = require("Utils")

local TextBox = { }

local kFonts = { }

local function DrawTextBox(textBox, xSize, ySize)

    love.graphics.setFont(textBox.font)
    
    local textWidth = textBox.font:getWidth(textBox.text)
    local textHeight = textBox.font:getHeight(textBox.text)
    
    local x, y, boxXSize, boxYSize = Utils.CalcTranslate(xSize, ySize, textWidth / xSize, textHeight / ySize,
                                                         textBox.xAlign, textBox.yAlign,
                                                         textBox.xAnchor, textBox.yAnchor)
    love.graphics.translate(x, y)
    
    love.graphics.setColor(textBox.red or 0, textBox.green or 0, textBox.blue or 0, textBox.alpha or 255)
    love.graphics.print(textBox.text, 0, 0)
    
    --love.graphics.rectangle("line", 0, 0, boxXSize, boxYSize)
    
end

TextBox.Create = function(text, xAnchor, yAnchor, size)

    if not kFonts[size] then
        kFonts[size] = love.graphics.newFont(size)
    end
    
    local textBox = { text = text, xAnchor = xAnchor, yAnchor = yAnchor, font = kFonts[size] }
    textBox.SetAlignment = Utils.SetBoxAlignment
    textBox.SetColor = Utils.SetColor
    textBox.Draw = DrawTextBox
    
    return textBox
    
end

return TextBox