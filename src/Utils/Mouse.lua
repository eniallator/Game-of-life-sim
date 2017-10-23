local mouse = {
    left = {id = 1},
    right = {id = 2},
    wheel = 0
}

local function checkClick(isDown, button)
    mouse[button].clicked = not mouse[button].held and isDown
end

mouse.reset = function()
  checkClick(love.mouse.isDown(1), "left")
  checkClick(love.mouse.isDown(2), "right")
  mouse.wheel = 0
end

local function updateMouseState(isDown, x, y, id)
  local button = id == 1 and "left" or "right"
  mouse[button].pos = {x = x, y = y}
  checkClick(isDown, button)
  mouse[button].held = isDown
end

function love.wheelmoved(x, y)
    mouse.wheel = y
end

function love.mousepressed(x, y, button, isTouch)
  updateMouseState(true, x, y, button)
end

function love.mousereleased(x, y, button, isTouch)
  updateMouseState(false, x, y, button)
end

return mouse