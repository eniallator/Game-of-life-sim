local mouse = require 'src.Utils.Mouse'

local input = {}
input.offset = {x = 0, y = 0}
input.zoom = 3
input.speed = 3

local mouseLastPos = {}
local zoomLowerLimit = 0.6
local zoomUpperLimit = 10
local zoomRate = 1 / 5

local function updateZoom(screenDim, tilePixels)
    local nextPos = input.zoom + input.zoom * (mouse.wheel * zoomRate)

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
    local mouseCurrPos = {}
    mouseCurrPos.x, mouseCurrPos.y = love.mouse.getPosition()

    if mouse.left.clicked then
        mouseLastPos.x, mouseLastPos.y = love.mouse.getPosition()
    end

    if mouse.left.held then
        input.offset.x = input.offset.x + mouseCurrPos.x - mouseLastPos.x
        input.offset.y = input.offset.y + mouseCurrPos.y - mouseLastPos.y

        mouseLastPos.x = mouseCurrPos.x
        mouseLastPos.y = mouseCurrPos.y
    end
end

input.update = function(dt, screenDim, tilePixels)
    updateZoom(screenDim, tilePixels)
    updateOffset()
    mouse.reset()
end

return input
