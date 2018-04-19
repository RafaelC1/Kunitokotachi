require "object"

Asteroid = {}

function Asteroid.new(args)
  local self = Object.new(args)

  self.r = 66
  self.g = 49
  self.b = 30

  function self.update(dt)
    self.down(dt)
  end

  return self
end