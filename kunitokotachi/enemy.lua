require "body"
require "class"
require "health"
require "helpers"
require "weapons_manager"

Enemy = {}

function Enemy.new(args)
  local self = Class.new()

  self.inherit(Body.new(args))
  self.inherit(Health.new(args))
  self.inherit(WeaponsManager.new())

  self.title = 'enemy'

  self.owner = args.owner or self

  self.kill_points = 100 -- points for kill this enemy
  self.drop = args.drop or 'power'
  self.IA = -- this is the positions that enemy shoud perform during it's life circle
  {
    current_position = 1, -- the current position of it's life circle
    behaviour = {}
  }
  self.IA.behaviour = args.behaviour or nil
  self.bullet_type = args.bullet_type or 'enemy_bullet_01'

  self.animations = args.animations or nil
  self.current_animation = self.animations.normal or nil

  self.weapons_settings = args.weapons_settings

-- this still
  self.blank_blink = false
  self.blank_blink_time = 0.05
  self.current_blank_blink_time = 0

  function self.change_normal_animation()
    self.change_animation('normal')
  end

  function self.change_attack_animation()
    self.change_animation('attack')
  end

  function self.change_die_animation()
    self.change_animation('die')
  end

  function self.current_animation_ended()
    return self.current_animation.ended
  end

-- this method change to the animation sended as parameter
  function self.change_animation(new_animation)
    if self.animations[new_animation] ~= nil then
      self.current_animation = self.animations[new_animation]
    else
      self.current_animation = self.animations.normal
    end
    self.current_animation.start()
  end

  -- this method give enemy bonur for kill but make it to zero to prevent double gain
  function self.give_bonus()
    local bonus = self.kill_points
    self.kill_points = 0
    return bonus
  end
  -- enemy need to overwrite this method since it can only die when animation of dying over
  function self.dead_animation_ended()
    if self.current_animation == self.animations.die and self.current_animation_ended() then
      return true
    else
      return true
    end
  end
  -- move enemy acording IA
  function self.move(dt)
    if self.IA.behaviour == nil or self.IA.current_position > #self.IA.behaviour or self.current_hp <= 0 then
      self.down(dt)
      return
    end

    local extra_margin = 5;

    local onX = false
    local onY = false

    if self.body.x < (self.IA.behaviour[self.IA.current_position].x-extra_margin) then
      self.right(dt)
    elseif self.body.x > (self.IA.behaviour[self.IA.current_position].x+extra_margin) then
      self.left(dt)
    else
      onX = true
    end

    if self.body.y < (self.IA.behaviour[self.IA.current_position].y-extra_margin) then
      self.down(dt)
    elseif self.body.y > (self.IA.behaviour[self.IA.current_position].y+extra_margin) then
      self.up(dt)
    else
      onY = true
    end

    if onX and onY then
      if self.IA.behaviour[self.IA.current_position].action == "shoot" then
        self:shoot_every_weapon()
        self.change_attack_animation()
      end
      if self.IA.behaviour[self.IA.current_position].action == "repeat" then
        self.IA.current_position = 1
      else
        self.IA.current_position = self.IA.current_position + 1
      end
    end
  end

  function self.blink_blank_by_hit()
    if self.current_blank_blink_time <= 0 then
      self.start_blank_blink()
    end
  end

  function self.start_blank_blink()
    self.blank_blink = true
  end

  function self.update_current_blank_time(dt)
    -- the purpouse of this logic is to prevent the sprite to blink with the "hit color"
    -- even if the enemy is been attacked with a constante hit such a laser
    if self.blank_blink then
      if self.current_blank_blink_time >= self.blank_blink_time then
        self.blank_blink = false
      end
      self.current_blank_blink_time = self.current_blank_blink_time + dt
    elseif self.current_blank_blink_time > 0 then
      self.current_blank_blink_time = self.current_blank_blink_time - dt
    end
  end

  function self.update(dt)
    if not self.is_alive() then
      self.change_die_animation()
      self.down(dt)
      return
    end

    self.move(dt)
    if self.current_animation ~= nil then
      self.current_animation.update(dt)
      if self.current_animation_ended() then
        self.current_animation = self.animations.normal
      end
    end

    if self.blank_blink or self.current_blank_blink_time > 0 then
      self.update_current_blank_time(dt)
    end
  end

  function self.draw()
    -- self.draw_test()
    local r, g, b, a = love.graphics.getColor()
    if self.current_animation ~= nil then
      if self.blank_blink then
        love.graphics.setColor(255, 0, 0, 1)
      end
      self.current_animation.draw{x=self.body.x, y=self.body.y, scala_x=1, scala_y=1, rot=0}
      if self.blank_blink then
        love.graphics.setColor(r, g, b, a)
      end
    end
  end

  function self.prepare_weapons()
    if self.weapons_settings == nil then
      return
    end
    for w_name, w_settings in pairs(self.weapons_settings) do
      self.add_weapon{ammo_name=args.ammo_name,
                      delay=0,
                      relative_x=0,
                      relative_y=0,
                      direction_x=w_settings.direction_x,
                      direction_y=w_settings.direction_y}
    end
  end

  self.current_animation.start()
  self.current_animation.repeat_on_end() -- turn only the normal animation to keep repeting

  self.prepare_weapons()

  return self
end