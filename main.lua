local paused, applyRules, display
local screenDim = {}
local aliveCells = {{20, 14}, {19, 15}, {20, 15}, {20, 16}, {21, 16}}
local zoom = 2
local speed = 1
local timer = 0

function love.load(args)
    love.graphics.setDefaultFilter("nearest", "nearest")
    screenDim.x, screenDim.y = love.graphics.getDimensions()

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
