local mouse = require 'src.Utils.Mouse'

local input = {}
input.offset = {x = 0, y = 0}
input.zoom = 3
input.speed = 3

local offsetLastPos = {x = 0, y = 0}
local zoomLowerLimit = 1
local zoomUpperLimit = 10
local zoomRate = 1 / 5

local function addZoom()
    local nextPos = input.zoom + (mouse.wheel * zoomRate)

    if nextPos >= zoomLowerLimit and nextPos <= zoomUpperLimit then
        input.zoom = nextPos
    end
end

local function addOffset()
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

input.update = function(dt)
    addZoom()
    addOffset()
    mouse.reset()
end

return input
