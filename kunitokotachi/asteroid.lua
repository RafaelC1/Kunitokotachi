require "class"
require "body"

Asteroid = {}

function Asteroid.new(args)
  local self = Class.new()

  self.inherit(Body.new(args))
  self.inherit(Health.new(args))

  self.animations = args.animations or nil

  self.title = 'enemy'  

  function self.update(dt)
    self.down(dt)
    self.animations.update(dt)
  end

  function self.draw()
    self.animations.draw{x=self.body.x, y=self.body.y, scala_x=1, scala_y=1, rot=0}
  end

  self.invulnerable = true

  return self
end
