require "class"
require "body"

Asteroid = {}

function Asteroid.new(args)
  local self = Class.new()

  self.inherit(Body.new(args))
  self.inherit(Health.new(args))

  self.title = 'enemy'

  self.r = 66
  self.g = 49
  self.b = 30

  function self.update(dt)
    self.down(dt)
  end

  return self
end