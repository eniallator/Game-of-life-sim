local utils = require 'src.Utils'

local textures = {
    tileSize = 10,
    deadCell = love.graphics.newImage('assets/textures/tiles/dead_cell.png'),
    aliveCell = love.graphics.newImage('assets/textures/tiles/alive_cell.png')
}
local spriteBatch = {
    deadCell = love.graphics.newSpriteBatch(textures.deadCell, 20000, 'stream'),
    aliveCell = love.graphics.newSpriteBatch(textures.aliveCell, 20000, 'stream')
}

local display = {}

local function populateSpriteBatch(aliveCells, screenDim, zoom)
    for x = 1, screenDim.x / (textures.tileSize * zoom) do
        for y = 1, screenDim.y / (textures.tileSize * zoom) do
            if utils.find({x, y}, aliveCells) then
                spriteBatch.aliveCell:add((x - 1) * textures.tileSize * zoom, (y - 1) * textures.tileSize * zoom, 0, zoom, zoom)

            else
                spriteBatch.deadCell:add((x - 1) * textures.tileSize * zoom, (y - 1) * textures.tileSize * zoom, 0, zoom, zoom)
            end
        end
    end
end

display.cells = function(aliveCells, screenDim, zoom)
    for _, batch in pairs(spriteBatch) do
        batch:clear()
    end

    populateSpriteBatch(aliveCells, screenDim, zoom)

    for _, batch in pairs(spriteBatch) do
        batch:flush()
        love.graphics.draw(batch)
    end
end

return display
