require "health"

Boss = {}

function Boss.new(args)
  local self = Class.new()
  self.inherit(Enemy.new(args))

  self.title = 'boss'
  self.kill_points = 10000

  self.sprite_position = {}
  self.sprite_position.extra_x = args.extra_x_sprite or 0
  self.sprite_position.extra_y = args.extra_y_sprite or 0

  function self.draw()
    -- self.draw_test()
    local r, g, b, a = love.graphics.getColor()
    if self.current_animation ~= nil then
      if self.blank_blink then
        love.graphics.setColor(255, 0, 0, 1)
      end
      self.current_animation.draw{x=self.body.x+self.sprite_position.extra_x,
                                  y=self.body.y+self.sprite_position.extra_y,
                                  scala_x=1,
                                  scala_y=1,
                                  rot=0}
      if self.blank_blink then
        love.graphics.setColor(r, g, b, a)
      end
    end
  end

  return self
end