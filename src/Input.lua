local mouse = require 'src.Utils.Mouse'

local input = {}
input.zoom = 3
input.speed = 3

local zoomLowerLimit = 1
local zoomUpperLimit = 10
local zoomRate = 1 / 5

local function addZoom()
    local nextPos = input.zoom + (mouse.wheel * zoomRate)
    
    if nextPos >= zoomLowerLimit and nextPos <= zoomUpperLimit then
        input.zoom = nextPos
    end
end

input.update = function(dt)
    addZoom()
    mouse.reset()
end

return input
