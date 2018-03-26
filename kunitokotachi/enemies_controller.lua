require "enemy"
require "helpers"
require "position_helpers"

EnemiesController = {}

function EnemiesController.new()
  local self = {}
  self.enemies = {}
  self.asteroids = {}

  self.enemies_characteristics = json_to_table(read_from('res/settings/enemies_characteristics.json'))
  self.asteroids_characteristics =  json_to_table(read_from('res/settings/asteroids_characteristics.json'))

  self.enemies_behaviours = json_to_table(read_from('res/settings/enemies_behaviours.json'))

  function self.create_enemy(x, y, enemy_type, behaviour)
    x = x or 100
    y = y or 100
    enemy_type = enemy_type or "eye"
    local enemy_model = self.enemies_characteristics.enemy[enemy_type]
    local enemy_behaviour = self.enemies_behaviours[behaviour]
    local enemy = Enemy.new{x=x, y=y, speed=enemy_model.speed, max_hp=enemy_model.max_hp, defense=enemy_model.defense, behaviour=enemy_behaviour, bullet_type=enemy_model.bullet_name}
    table.insert(self.enemies, enemy)
  end
  function self.create_asteroid(x, y, asteroid_type)
    
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
  function self.has_enemies()
    return #self.enemies > 0
  end
  function self.all_enemy_names()
    return self.enemies_characteristics.enemy_names
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