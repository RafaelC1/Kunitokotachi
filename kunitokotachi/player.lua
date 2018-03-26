require "ship"

Player = {}

function Player.new(player, keys, levels_of_player_settings)
  local self = {}
  self.player = 1
  self.name = 'rafael'
  self.lives = 3
  self.score = 0
  self.ship = {}
  self.keys = keys
  self.ship_model = ship_model or 'ship01'
  self.player = player
  self.level_settings = levels_of_player_settings or {}

  -- add score
  function self.create_ship()
    local ship_model = game_controller.ship_models[self.ship_model]
    self.ship = Ship.new{radio=ship_model.radio, speed=ship_model.speed, sprites=ship_sprites, keys=self.keys, owner=self, self_controller=true, max_hp=ship_model.max_hp}
    spawn_pos_x = game_controller.spawn_pos['player'..self.player].x
    spawn_pos_y = game_controller.spawn_pos['player'..self.player].y
    self.ship.teleport_to(spawn_pos_x, spawn_pos_y)
  end
  function self.destroy_ship()
    self.ship = {}
  end
  function self.earn_points(score)
    score = score or 1
    self.score = self.score + score
  end
  -- perform a death
  function self.die()
    self.lives = self.lives-1
    self.ship = {}
    -- if player have extra lives available, respawn his ship
    if self.has_extra_lives() then
      self.create_ship()
    end
  end
  function self.level_exist(level)
    if self.level_settings[string.format("level_%02d", level)] == nil then
      return false
    else
      return true
    end
  end
  function self.has_extra_lives()
    return self.lives > 0
  end
  function self.ship_is_alive()
    if self.ship.is_alive and self.ship.is_alive() then
      return true
    else
      return false
    end
  end
  function self.update(dt)
    if self.ship.update then
      self.ship.update(dt)
    end
  end
  function self.draw()
    if self.ship.draw then
      self.ship.draw()
    end
  end

  return self
end