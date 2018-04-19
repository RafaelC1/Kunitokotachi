require "object"

PowerUp = {}

function PowerUp.new(args)
  local self = Object.new(args)

  self.r = 0
  self.g = 255
  self.b = 0

  self.power = args.power
  self.power_type = args.power_type or 'power'
  self.vanish_time = args.vanish_time or -1

  function self.update(dt)
    self.down(dt)
  end
  function self.draw()
    love.graphics.setColor(self.r, self.g, self.b)
    love.graphics.circle('fill', self.body.x, self.body.y, self.body.radio)
  end

  return self
end