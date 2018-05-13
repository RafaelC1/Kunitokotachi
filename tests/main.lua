
local Object = {}

function Object.new()
  local self = {}
  self.x = 100
  self.y = 100
  self.radio = 30

  return self
end

local o = Object.new()

local current_speed = 100
local extra_speed = 10

function love.keypressed(key)
  if key == 'up' then
    current_speed = current_speed + extra_speed
  elseif key == 'down' and current_speed > 0 then
    current_speed = current_speed - extra_speed
  end
end

function love.load()
  
end

function love.update(dt)
  local vertical_speed = 0
  local horizontal_speed = 0

  if love.keyboard.isDown('w') then
    vertical_speed = -current_speed*dt
  end

  if love.keyboard.isDown('s') then
    vertical_speed = current_speed*dt
  end

  if love.keyboard.isDown('a') then
   horizontal_speed = -current_speed*dt
  end

  if love.keyboard.isDown('d') then
    horizontal_speed = current_speed*dt
  end

  if vertical_speed ~= 0 and horizontal_speed ~= 0 then
    vertical_speed = vertical_speed/2
    horizontal_speed = horizontal_speed/2
  end

  o.x = o.x + horizontal_speed
  o.y = o.y + vertical_speed
end

function love.draw()
  local text = 'speed: '..current_speed..' | use WSAD to controll the circle and increase/decrease speed with UP and DOWN keys'
  love.graphics.print(text, 10, 10)
  love.graphics.circle("fill", o.x, o.y, o.radio)
end