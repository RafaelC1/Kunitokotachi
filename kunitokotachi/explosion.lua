Explosion = {}

function Explosion.new(animation, x, y, down_speed)
  local self = {}
  self.animation = animation
  self.finished = false
  self.speed = down_speed
  self.x = x
  self.y = y

  function self.move_down(dt)
    self.y = self.y + self.speed*dt
  end

  function self.update(dt)
    self.move_down(dt)
    self.animation.update(dt)
    self.finished = self.animation.ended
    print(self.finished)
  end
  function self.draw()
    self.animation.draw{x=self.x, y=self.y, scala_x=1, scala_y=1, rot=0}
  end

  self.animation.dont_repeat()
  self.animation.start()

  return self
end