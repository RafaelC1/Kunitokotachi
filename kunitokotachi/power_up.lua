require "class"
require "health"
require "body"

PowerUp = {}

function PowerUp.new(args)
  local self = Class.new()

  self.inherit(Body.new(args))
  self.animation = args.animation

  self.title = 'power_up'

  self.power = args.power
  self.power_type = args.power_type or 'power'
  self.vanish_time = args.vanish_time

  self.time_to_decrease_blink = 1
  self.curent_time_to_decrease_blink = 0

  self.blink = false -- true mean that animation should show up, false is the oposite

  self.blink_on_time = 0.75 -- time that animation be on
  self.blink_off_time = 0.15 -- time that atnimation be off

  self.current_blink_time = 0 -- current blink time to both, on and off

  function self.count_current_blink_time(dt)
    self.current_blink_time = self.current_blink_time + dt
  end

  -- this method manager the blink time of power up
  -- the blink will be more and more quickly acording the power up get close to vanish by it self
  function self.manager_blink(dt)
    if self.blink then
      if self.current_blink_time >= self.blink_on_time then
        self.current_blink_time = 0
        -- this check grante that the animation will not be of more time than on
        -- instead will be reducing until both be on the same time
        if self.blink_on_time > self.blink_off_time then
          self.blink_on_time = self.blink_on_time - self.blink_off_time
        else
          self.blink_on_time = self.blink_off_time
        end
        self.blink = false
      end
    else
      if self.current_blink_time >= self.blink_off_time then
        self.current_blink_time = 0
        self.blink = true
      end
    end
    self.count_current_blink_time(dt)
  end

  function self.vanished()
    return self.vanish_time <= 0
  end

-- this method will count the life time of this power up until become zero when it disapear
  function self.count_down_life_time(dt)
    self.vanish_time = self.vanish_time - dt
  end

  function self.update(dt)
    self.manager_blink(dt)
    self.count_down_life_time(dt)
    self.down(dt)
  end

  function self.draw()
    love.graphics.setColor(self.r, self.g, self.b)
    love.graphics.circle('fill', self.body.x, self.body.y, self.body.radio)
    -- animation shoul only apear when blink is true
    if self.blink then
      self.animation.draw{x=self.body.x, y=self.body.y, scala_x=1, scala_y=1, rot=0}
    end
  end

  return self
end