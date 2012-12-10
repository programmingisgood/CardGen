
local ContentBox = { }

local kToPercent = { }
kToPercent.min = 0
kToPercent.center = 0.5
kToPercent.max = 1

local function CalcTranslate(outerXSize, outerYSize, xSize, ySize, xAlign, yAlign, xAnchor, yAnchor)

    local boxXSize = xSize * outerXSize
    local boxYSize = ySize * outerYSize
    
    local xAlignAmt = (kToPercent[xAlign] or 0) * boxXSize
    local yAlignAmt = (kToPercent[yAlign] or 0) * boxYSize
    return kToPercent[xAnchor] * outerXSize - xAlignAmt,
           kToPercent[yAnchor] * outerYSize - yAlignAmt,
           boxXSize, boxYSize
    
end

local kTextAlign = { ["min"] = "left", ["center"] = "center", ["max"] = "right" }
local function DrawTextBox(textBox, xSize, ySize)

    local x, y, boxXSize, boxYSize = CalcTranslate(xSize, ySize, textBox.xSize, textBox.ySize,
                                                   textBox.xAlign, textBox.yAlign,
                                                   textBox.xAnchor, textBox.yAnchor)
    love.graphics.translate(x, y)
    
    love.graphics.printf(textBox.text, 0, 0, 0)--, kTextAlign[textBox.xAlign or "min"])
    
    love.graphics.rectangle("line", 0, 0, boxXSize, boxYSize)
    
end

local function DrawContentBox(contentBox, xSize, ySize)

    local x, y, boxXSize, boxYSize = CalcTranslate(xSize, ySize, contentBox.xSize, contentBox.ySize,
                                                   contentBox.xAlign, contentBox.yAlign,
                                                   contentBox.xAnchor, contentBox.yAnchor)
    love.graphics.translate(x, y)
    
    love.graphics.setColor(0, 0, 0, 255)
    
    love.graphics.rectangle("line", 0, 0, boxXSize, boxYSize)
    
    for c = 1, #contentBox.contents do
    
        love.graphics.push()
        contentBox.contents[c]:Draw(boxXSize, boxYSize)
        love.graphics.pop()
        
    end
    
end

local function SetBoxAlignment(box, xAlign, yAlign)

    box.xAlign = xAlign
    box.yAlign = yAlign
    
end

local function AddTextBox(contentBox, text, xAnchor, yAnchor, xSize, ySize)

    local textBox = { text = text, xAnchor = xAnchor, yAnchor = yAnchor, xSize = xSize, ySize = ySize }
    textBox.SetAlignment = SetBoxAlignment
    textBox.Draw = DrawTextBox
    table.insert(contentBox.contents, textBox)
    
    return textBox
    
end

ContentBox.Create = function(xAnchor, yAnchor, xSize, ySize)

    local contentBox = { xAnchor = xAnchor, yAnchor = yAnchor, xSize = xSize, ySize = ySize }
    contentBox.contents = { }
    contentBox.Draw = DrawContentBox
    contentBox.SetAlignment = SetBoxAlignment
    contentBox.AddTextBox = AddTextBox
    
    return contentBox
    
end

return ContentBox