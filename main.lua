local paused, gol, input
local screenDim = {}

function love.load(args)
    love.graphics.setDefaultFilter("nearest", "nearest")
    screenDim.x, screenDim.y = love.graphics.getDimensions()

    input = require 'src.Input'
    gol = require 'src.Gol.Gol'
    
    local x, y = -math.floor(screenDim.x / (2 * 10 * input.zoom)), -math.floor(screenDim.y / (2 * 10 * input.zoom))
    gol.aliveCells = {{x, y - 1}, {x - 1, y}, {x, y}, {x, y + 1}, {x + 1, y + 1}}
end

function love.update(dt)
    gol.update(dt, input.speed, aliveCells)
    input.update(dt, screenDim, gol.tilePixels)
end

function love.draw()
    gol.display(screenDim, input.zoom, input.offset)
end
