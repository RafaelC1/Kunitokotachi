Weapon = {}

function Weapon.new(args)
  local self = {}

  self.actived = false

  self.ammo_name = args.ammo_name
  self.delay = args.delay or 0
  self.current_time = 0

  self.relative = {}
  self.relative.x = args.relative_x or 0
  self.relative.y = args.relative_y or 0

  self.direction = {}
  self.direction.x = args.direction_x
  self.direction.y = args.direction_y

  function self.active()
    self.actived = true
  end

  function self.deactivate()
    self.actived = false
  end

  function self.change_delay_to(new_delay)
    self.delay = new_delay
  end

  function self.change_ammo_to(new_ammo_name)
    self.ammo_name = new_ammo_name
  end

  function self:update_delay(dt)
    self.current_time = self.current_time+dt
  end

  function self.can_shoot()
    if self.current_time >= self.delay then
      return true
    else
      return false
    end
  end

  function self.correct_position(old_x, old_y)
    local new_x = old_x+self.relative.x
    local new_y = old_y+self.relative.y
    return new_x, new_y
  end

  function self.shoot(x_pos, y_pos, owner, owner_title)
    if self.can_shoot() then
      x_pos, y_pos = self.correct_position(x_pos, y_pos)
      bullets_controller.create_bullet(x_pos, y_pos, self.direction.x, self.direction.y, self.ammo_name, owner, owner_title)
      self.current_time = 0
    end
  end

  function self:update(dt)
    if not self.can_shoot() then
      self:update_delay(dt)
    end
  end

  return self
end