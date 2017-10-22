local paused, applyRules, display
local aliveCells = {}
local screenDim = {}
local zoom = 1
local speed = 10
local timer = 0

function love.load(args)
    love.graphics.setDefaultFilter("nearest", "nearest")
    screenDim.x, screenDim.y = love.graphics.getDimensions()
    local x, y = math.floor(screenDim.x / (2 * 10 * zoom)), math.floor(screenDim.y / (2 * 10 * zoom))
    aliveCells = {{x, y - 1}, {x - 1, y}, {x, y}, {x, y + 1}, {x + 1, y + 1}}

    applyRules = require 'src.GolRules'
    display = require 'src.Display'
end

function love.update(dt)
    while timer > 1 / speed do
        timer = timer - 1 / speed
        aliveCells = applyRules(aliveCells)
    end

    timer = timer + dt
end

function love.draw()
    display.cells(aliveCells, screenDim, zoom)
end
