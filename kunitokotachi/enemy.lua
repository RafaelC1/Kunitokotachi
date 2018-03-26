require "object"
require "helpers"

Enemy = {}

function Enemy.new(args)
  local self = Object.new(args)

  self.kill_points = 100 -- points for kill this enemy
  self.drop = args.drop or 'power'
  self.IA = -- this is the positions that enemy shoud perform during it's life circle
  {
    current_position = 1, -- the current position of it's life circle
    behaviour = {}
  }
  self.IA.behaviour = args.behaviour or nil
  self.bullet_type = args.bullet_type or 'enemy_bullet_01'

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
      if self.IA.behaviour[self.IA.current_position].action == "shoot" then self.shoot() end
      if self.IA.behaviour[self.IA.current_position].action == "repeat" then
        self.IA.current_position = 1
      else
        self.IA.current_position = self.IA.current_position + 1
      end
    end
  end
  function self.shoot()
    bullets_controller.create_bullet(self.body.x, self.body.y, 0, 1, 'enemy', self.bullet_type, self)
    -- bullets_controller.create_bullet(self.body.x, self.body.y-self.body.radio/3, 0, -1, 'player', self.current_ammo().bullet, self.owner)
  end
  -- die and spawm some gift
  function self.is_alive()
    if self.current_hp > 0 then
      return true
    else
      return false
    end
  end
  function self.update(dt)
    self.move(dt)
  end

  return self
end