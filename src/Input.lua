local mouse = require 'src.Utils.Mouse'

local input = {}
input.offset = {x = 0, y = 0}
input.zoom = 3
input.speed = 3

local offsetLastPos = {x = 0, y = 0}
local zoomLowerLimit = 0.6
local zoomUpperLimit = 10
local zoomRate = 1 / 5

local function updateZoom(tilePixels)
    local nextPos = input.zoom + (mouse.wheel * zoomRate)

    if mouse.wheel ~= 0 and nextPos >= zoomLowerLimit and nextPos <= zoomUpperLimit then
        -- local mouseCurrPos = {}
        -- mouseCurrPos.x, mouseCurrPos.y = love.mouse.getPosition()

        -- local offsetRate = mouse.wheel * zoomRate / tilePixels
        -- offsetLastPos.x = offsetLastPos.x + (mouseCurrPos.x - offsetLastPos.x) * offsetRate
        -- offsetLastPos.y = offsetLastPos.y + (mouseCurrPos.y - offsetLastPos.y) * offsetRate
        -- input.offset.x = input.offset.x + (mouseCurrPos.x - input.offset.x) * offsetRate
        -- input.offset.y = input.offset.y + (mouseCurrPos.y - input.offset.y) * offsetRate

        input.zoom = nextPos
    end
end

local function updateOffset()
    if mouse.left.held then
        local mouseCurrPos = {}
        mouseCurrPos.x, mouseCurrPos.y = love.mouse.getPosition()
        input.offset.x = offsetLastPos.x + (mouseCurrPos.x - mouse.left.pos.x)
        input.offset.y = offsetLastPos.y + (mouseCurrPos.y - mouse.left.pos.y)
    else
        offsetLastPos.x = input.offset.x
        offsetLastPos.y = input.offset.y
    end
end

input.update = function(dt, tilePixels)
    updateZoom(tilePixels)
    updateOffset()
    mouse.reset()
end

return input
