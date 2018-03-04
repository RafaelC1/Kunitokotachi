require "enemy"
require "position_helpers"

EnemiesController = {}

function EnemiesController.new()
  local self =
  {
    enemies = {}
  }

  function self.create_enemy(x, y, enemy_type)
    x = x or 100
    y = y or 100
    enemy_type = enemy_type or "eye"
    -- local sprite = self.sprite_of_bullet_type(args.type)
    local enemy = Enemy.new{x=x, y=y, speed=400}
    table.insert(self.enemies, enemy)
  end
  function self.enemy_on_screen(enemy)
    if inside_screen_width(enemy.body.x) and inside_screen_height(enemy.body.y) then
      return true
    else
      return false
    end
  end
  -- spawn power up when enemy die if it shoul spawn
  function self.spawn_power_up(enemy_id)
    if self.enemies[enemy_id].drop == nil then return end
    local x = self.enemies[enemy_id].body.x
    local y = self.enemies[enemy_id].body.y
    local power_type = self.enemies[enemy_id].drop or 'power'
    power_ups_controller.create_power_up(x, y, power_type)
  end
  -- destroy an enemy by id
  function self.destroy_enemy(enemy_id)
    table.remove(self.enemies, enemy_id)
  end
  -- destroy all enemies on list
  function self.destroy_all_enemies()
    self.enemies = {}
  end

  function self.update(dt)
    for i, enemy in ipairs(self.enemies) do
      enemy.update(dt)
      if not enemy.is_alive() then
        self.spawn_power_up(i)
        self.destroy_enemy(i)
      end
      if not on_screen(enemy.body.x, enemy.body.y) then
        self.destroy_enemy(i)
      end
    end
  end
  function self.draw()
    for i, enemy in ipairs(self.enemies) do
      enemy.draw()
    end
  end

  return self

end