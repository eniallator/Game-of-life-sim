local utils = require 'src.Utils'
local createSpriteBatch = require 'src.SpriteBatch'

local textures = {
    tileSize = 10,
    deadCell = love.graphics.newImage('assets/textures/tiles/dead_cell.png'),
    aliveCell = love.graphics.newImage('assets/textures/tiles/alive_cell.png')
}
local tiles = {
    deadCell = createSpriteBatch(textures.deadCell, 10000, 'stream'),
    aliveCell = createSpriteBatch(textures.aliveCell, 10000, 'stream')
}

local display = {}

local function populateSpriteBatch(aliveCells, screenDim, zoom)
    for x = 1, screenDim.x / (textures.tileSize * zoom) do
        for y = 1, screenDim.y / (textures.tileSize * zoom) do
            if utils.find({x, y}, aliveCells) then
                tiles.aliveCell:add((x - 1) * textures.tileSize * zoom, (y - 1) * textures.tileSize * zoom, 0, zoom, zoom)

            else
                tiles.deadCell:add((x - 1) * textures.tileSize * zoom, (y - 1) * textures.tileSize * zoom, 0, zoom, zoom)
            end
        end
    end
end

display.cells = function(aliveCells, screenDim, zoom)
    for _, batch in pairs(tiles) do
        batch:clear()
    end

    populateSpriteBatch(aliveCells, screenDim, zoom)

    for _, batch in pairs(tiles) do
        batch:draw()
    end
end

return display
