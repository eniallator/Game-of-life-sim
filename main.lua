local screenDim, aliveCells, zoom, golRules, display = {}, {}, 0.5

function love.load(args)
    love.graphics.setDefaultFilter("nearest", "nearest")
    screenDim.x, screenDim.y = love.graphics.getDimensions()

    golRules = require 'src.GolRules'
    display = require 'src.Display'
end

function love.update(args)

end

function love.draw()
    display.cells(aliveCells, screenDim, zoom)
end
