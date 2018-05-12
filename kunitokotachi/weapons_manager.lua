require "weapon"

WeaponsManager = {}

-- this manager give the ability of who inherat to use weapons
function WeaponsManager.new()
  local self = {}

  self.weapons = {}

  function self.change_delay_of_all_weapons(new_delay)
    for _, weapon in ipairs(self.weapons) do
      weapon.change_delay_to(new_delay)
    end
  end

  function self.change_ammo_of_all_weapons(new_ammo)
    for _, weapon in ipairs(self.weapons) do
      weapon.change_ammo_to(new_ammo)
    end
  end

  function self.change_delay_of_weapon(weapon_id, new_delay)
    if self.weapons[weapon_id] ~= nil then
      self.weapons[weapon_id].change_delay_to(new_ammo)
    end
  end

  function self.change_ammo_of_weapon(weapon_id, new_ammo)
    if self.weapons[weapon_id] ~= nil then
      self.weapons[weapon_id].change_ammo_to(new_ammo)
    end
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