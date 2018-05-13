require "class"
require "body"

Asteroid = {}

function Asteroid.new(args)
  local self = Class.new()

  self.inherit(Body.new(args))
  self.inherit(Health.new(args))

  self.title = 'enemy'  

  function self.update(dt)
    self.down(dt)
  end

  self.invulnerable = true

  return self
end
