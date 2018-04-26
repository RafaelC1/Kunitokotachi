require "weapon"

WeaponsManager = {}

-- this manager give the ability of who inherat to use weapons
function WeaponsManager.new()
  local self = {}

  self.weapons = {}

  function self.ammo_of_type(ammo_name)
    return bullets_controller.bullets_settings[ammo_name]
  end

-- create a "weapon" with position relative the body of ship
  function self.add_weapon(ammo_name, x_pos_relative, y_pos_relative, delay)
    local new_weapon = Weapon.new(ammo_name, x_pos_relative, y_pos_relative, delay)
    new_weapon.active()
    self.weapons[#self.weapons+1] = new_weapon
  end

-- shoot all weapons at the same time (if it possible)
-- note that here we use : because body "doesn't belong to this class"
  function self:shoot_every_weapon()
    for _, weapon in ipairs(self.weapons) do
      if weapon.actived and weapon.can_shoot() then
        weapon.shoot(self.body.x, self.body.y, self.owner, self.title)
      end
    end
  end

  return self
end