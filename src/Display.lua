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

local function populateSpriteBatch(aliveCells, screenDim, zoom, offset)
    for x = 0, screenDim.x / (textures.tileSize * zoom) + 1 do
        for y = 0, screenDim.y / (textures.tileSize * zoom) + 1 do
            if utils.find({math.floor(offset.x / (textures.tileSize * zoom)) + x, math.floor(offset.y / (textures.tileSize * zoom)) + y}, aliveCells) then
                tiles.aliveCell:add((x - 1) * textures.tileSize * zoom, (y - 1) * textures.tileSize * zoom, 0, zoom, zoom)

            else
                tiles.deadCell:add((x - 1) * textures.tileSize * zoom, (y - 1) * textures.tileSize * zoom, 0, zoom, zoom)
            end
        end
    end
end

display.cells = function(aliveCells, screenDim, zoom, offset)
    for _, batch in pairs(tiles) do
        batch:clear()
    end

    populateSpriteBatch(aliveCells, screenDim, zoom, offset)

    for _, batch in pairs(tiles) do
        batch:draw(offset.x % (textures.tileSize * zoom), offset.y % (textures.tileSize * zoom))
    end
end

return display
