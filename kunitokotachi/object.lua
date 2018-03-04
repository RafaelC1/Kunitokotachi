require "helpers"

Object = {}

function Object.new(args)
  local self = {}
  self.body = {}
  self.body.radio = args.radio or 50
  self.body.x = args.x or 100
  self.body.y = args.y or 100
  self.body.type = args.type or 'player'
  self.sprite = args.sprites
  self.speed = args.speed or 700
  self.max_hp = args.max_hp
  self.current_hp = self.max_hp or 100
  self.defense = args.defense or 10

  function self.apply_damage(args)
    -- real damage that will be inflicted on enemy after calculate it based 
    self.current_hp = self.current_hp - calculate_damage(args.damage, self.defense)
    -- if enemy die, give points for the last one who hit inflicted
    if self.current_hp <= 0 and args.agressor.earn_points ~= nil then
      args.agressor.earn_points(self.kill_points)
      self.kill_points = 0 -- prevent that player can earn multiple time kill points (laser cause this)
    end
  end
  function self.up(dt)
    local y = -self.speed*dt
    self.vertical_move(y)
  end
  -- move character down
  function self.down(dt)
    local y = self.speed*dt
    self.vertical_move(y)
  end
  -- move character left
  function self.left(dt)
    local x = -self.speed*dt
    self.horizontal_move(x)
  end
  -- move character right
  function self.right(dt)
    local x = self.speed*dt
    self.horizontal_move(x)
  end
  -- perform horizontal move
  function self.horizontal_move(x)
    self.body.x = self.body.x + x
  end
  -- perform vertical move
  function self.vertical_move(y)
    self.body.y = self.body.y + y
  end
  function self.teleport_to(x, y)
    self.body.x = x
    self.body.y = y
  end
  function self.is_alive()
    if self.current_hp > 0 then
      return true
    else
      return false
    end
  end

  return self
end