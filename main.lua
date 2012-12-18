
local decks = nil
function love.load(args)

    love.filesystem.setIdentity("CardGen")
    if args[2] then
    
        decks = require(args[2])
        decks:Draw(4)
        
    end
    
end

local currentCanvas = 1
function love.draw()

    love.graphics.reset()
    
    love.graphics.draw(decks:GetCanvases()[currentCanvas], 0, 0)
    
    --love.event.push("quit")
    
end

function love.keypressed(k)

    if k == "escape" then
        love.event.push("quit")
    elseif k == "left" then
        currentCanvas = currentCanvas > 1 and (currentCanvas - 1) or 1
    elseif k == "right" then
        currentCanvas = currentCanvas < #decks:GetCanvases() and (currentCanvas + 1) or #decks:GetCanvases()
    end
    
end