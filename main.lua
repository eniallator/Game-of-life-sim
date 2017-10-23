local paused, Gol
local screenDim = {}
local offset = {x = 15, y = 15}
local speed = 3
local zoom = 3

function love.load(args)
    love.graphics.setDefaultFilter("nearest", "nearest")
    screenDim.x, screenDim.y = love.graphics.getDimensions()
    local x, y = math.floor(screenDim.x / (2 * 10 * zoom)), math.floor(screenDim.y / (2 * 10 * zoom))
    
    Gol = require 'src.Gol.Gol'
    Gol.aliveCells = {{x, y - 1}, {x - 1, y}, {x, y}, {x, y + 1}, {x + 1, y + 1}}
end

function love.update(dt)
    Gol.update(dt, speed, aliveCells)
end

function love.draw()
    Gol.display(screenDim, zoom, offset)
end
