require "health"

Boss02 = {}

function Boss02.new(args)
  local self = Class.new()

  self.all_animations_level = args.animations
  args.animations = self.all_animations_level.level_02

  self.inherit(Enemy.new(args))

  self.title = 'boss'
  self.kill_points = 10000

  self.sprite_position = {}
  self.sprite_position.extra_x = args.extra_x_sprite or 0
  self.sprite_position.extra_y = args.extra_y_sprite or 0

  function self.define_curret_animation()
    if self.current_hp >= self.max_hp/2 then
      return self.all_animations_level.level_01.normal
    else
      return self.all_animations_level.level_02.normal
    end
  end

  function self:update(dt)
    if not self.is_alive() then
      self.change_die_animation()
      self.down(dt)
      return
    end

    self.move(dt)
    if self.current_animation ~= nil then
      self.current_animation:update(dt)
      if self.current_animation_ended() then
        self.current_animation = self.animations.normal
      end
    end

    if self.blank_blink or self.current_blank_blink_time > 0 then
      self:update_current_blank_time(dt)
    end

    self.current_animation =  self.define_curret_animation()
  end

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