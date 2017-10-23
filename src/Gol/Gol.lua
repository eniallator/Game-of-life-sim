local createSpriteBatch = require 'src.SpriteBatch'
local applyRules = require 'src.gol.Rules'
local utils = require 'src.Utils.Utils'

local gol = {}
gol.aliveCells = {}
gol.tilePixels = 10

local timer = 0
local textures = {
    deadCell = love.graphics.newImage('assets/textures/tiles/dead_cell.png'),
    aliveCell = love.graphics.newImage('assets/textures/tiles/alive_cell.png')
}
local tiles = {
    deadCell = createSpriteBatch(textures.deadCell, 10000, 'stream'),
    aliveCell = createSpriteBatch(textures.aliveCell, 10000, 'stream')
}

local function populateSpriteBatch(aliveCells, screenDim, zoom, offset)
    for x = 0, screenDim.x / (gol.tilePixels * zoom) + 1 do
        for y = 0, screenDim.y / (gol.tilePixels * zoom) + 1 do
            if utils.find({math.floor(offset.x / (gol.tilePixels * zoom)) - x, math.floor(offset.y / (gol.tilePixels * zoom)) - y}, aliveCells) then
                tiles.aliveCell:add((x - 1) * gol.tilePixels * zoom, (y - 1) * gol.tilePixels * zoom, 0, zoom, zoom)

            else
                tiles.deadCell:add((x - 1) * gol.tilePixels * zoom, (y - 1) * gol.tilePixels * zoom, 0, zoom, zoom)
            end
        end
    end
end

gol.display = function(screenDim, zoom, offset)
    for _, batch in pairs(tiles) do
        batch:clear()
    end

    populateSpriteBatch(gol.aliveCells, screenDim, zoom, offset)

    for _, batch in pairs(tiles) do
        batch:draw(offset.x % (gol.tilePixels * zoom), offset.y % (gol.tilePixels * zoom), 0)
    end
end

gol.update = function(dt, speed)
    while timer > 1 / speed do
        timer = timer - 1 / speed
        gol.aliveCells = applyRules(gol.aliveCells)
    end

    timer = timer + dt
end

return gol
