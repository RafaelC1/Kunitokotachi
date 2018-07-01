require "ship"

Player = {}

function Player.new(player, keys, levels_of_player_settings, player_name)
  local self = {}
  self.name = player_name
  self.title = 'player'
  self.lives = 3
  self.score = 0
  self.ship = {}
  self.keys = keys
  self.ship_model = ship_model or 'ship_01'
  self.player = player or 1
  self.level_settings = levels_of_player_settings or {}

  -- add score
  function self.create_ship()
    local ship_model = game_controller.ship_models[self.ship_model]
    self.ship = Ship.new{radio=ship_model.radio,
                        speed=ship_model.speed,
                        sprites=ship_sprites,
                        keys=self.keys,
                        owner=self,
                        self_controller=false,
                        max_hp=ship_model.max_hp,
                        ship_model_name=self.ship_model}
    self.set_ship_to_bottom_position()
  end

  function self.send_ship_to_top()
    local current_x = self.ship.body.x
    self.ship.set_self_controll_to(current_x, -100)
  end

  function self.set_ship_to_bottom_position()
    local spawn_pos_x = game_controller.spawn_pos['player'..self.player].x
    local spawn_pos_y = game_controller.spawn_pos['player'..self.player].y
    self.ship.teleport_to(spawn_pos_x, spawn_pos_y)
    self.ship.set_self_controll_to(spawn_pos_x, 500)
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
    explosions_controller.create_explosion(self.ship.body.x, self.ship.body.y)
    self.lives = self.lives-1
    self.ship = nil
    -- if player have extra lives available, respawn his ship
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
    return self.ship ~= nil and self.ship.is_alive()
  end

  function self.update(dt)
    if self.ship then
      self.ship.update(dt)
    end
  end

  function self.draw()
    if self.ship then
      self.ship.draw()
    end
  end

  return self
end