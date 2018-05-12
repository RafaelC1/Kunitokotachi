Body = {}

function Body.new(args)
  local self = {}

  self.body = {}
  self.body.x = args.x or 100
  self.body.y = args.y or 100
  self.body.type = args.type or 'player'
  self.body.radio = args.radio or 50

  self.speed = args.speed or 700

  self.invulnerable = false or args.invulnerable

  self.r = 255
  self.g = 255
  self.b = 255

  function self.up(dt)
    local y = -self.speed*dt
    self.vertical_move(y)
  end
  -- move character down
  function self.down(dt)
    local y = self.speed*dt
    self.vertical_move(y)
  end
  -- move character left
  function self.left(dt)
    local x = -self.speed*dt
    self.horizontal_move(x)
  end
  -- move character right
  function self.right(dt)
    local x = self.speed*dt
    self.horizontal_move(x)
  end
  -- perform horizontal move
  function self.horizontal_move(x)
    self.body.x = self.body.x + x
  end
  -- perform vertical move
  function self.vertical_move(y)
    self.body.y = self.body.y + y
  end

  function self.teleport_to(x, y)
    self.body.x = x
    self.body.y = y
  end

  function self.direction_of(x, y)
    if x == 0 and y == 0 then
      return 0
    elseif x == 0 and y == -1 then
      return 0
    elseif x == 1 and y == -1 then
      return 45
    elseif x == 1 and y == 0 then
      return 90
    elseif x == 1 and y == 1 then
      return 135
    elseif x == 0 and y == 1 then
      return 180
    elseif x == -1 and y == 1 then
      return 225
    elseif x == -1 and y == 0 then
      return 270
    elseif x == -1 and y == -1 then
      return 315
    else
      return 360
    end
  end

  function self.draw_test()
    love.graphics.setColor(self.r, self.g, self.b)
    love.graphics.circle("fill", self.body.x, self.body.y, self.body.radio)
  end

  function self.draw()
    self.draw_test()
  end

  return self
end