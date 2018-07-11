Explosion = {}

function Explosion.new(animation, x, y, vertial_speed, horizontal_speed)
  local self = Class.new()
  self.animation = animation
  self.finished = false
  self.horizontal_speed = horizontal_speed
  self.vertial_speed = vertial_speed
  self.x = x
  self.y = y

  function self.move(dt)
    self.x = self.x + self.horizontal_speed * dt
    self.y = self.y + self.vertial_speed * dt
  end

  function self:update(dt)
    self.move(dt)
    self.animation:update(dt)
    self.finished = self.animation.ended
  end
  function self.draw()
    self.animation.draw{x=self.x, y=self.y, scala_x=1, scala_y=1, rot=0}
  end

  self.animation.dont_repeat()
  self.animation.start()

  return self
end