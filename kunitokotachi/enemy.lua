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

  self.r = 255
  self.g = 255
  self.b = 0

  self.kill_points = 100 -- points for kill this enemy
  self.drop = args.drop or 'power'
  self.IA = -- this is the positions that enemy shoud perform during it's life circle
  {
    current_position = 1, -- the current position of it's life circle
    behaviour = {}
  }
  self.IA.behaviour = args.behaviour or nil
  self.bullet_type = args.bullet_type or 'enemy_bullet_01'

  -- this method give enemy bonur for kill but make it to zero to prevent double gain
  function self.give_bonus()
    local bonus = self.kill_points
    self.kill_points = 0
    return bonus
  end
  -- move enemy acording IA
  function self.move(dt)
    if self.IA.behaviour == nil or self.IA.current_position > #self.IA.behaviour then
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
      end
      if self.IA.behaviour[self.IA.current_position].action == "repeat" then
        self.IA.current_position = 1
      else
        self.IA.current_position = self.IA.current_position + 1
      end
    end
  end

  function self.update(dt)
    self.move(dt)
  end

  self.add_weapon{ammo_name=args.ammo_name,
                  delay=0,
                  relative_x=0,
                  relative_y=0,
                  direction_x=0,
                  direction_y=1}

  return self
end