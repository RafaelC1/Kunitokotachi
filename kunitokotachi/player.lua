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
    self.ship = Ship.new{radio=ship_model.radio, speed=ship_model.speed, sprites=ship_sprites, keys=self.keys, owner=self, self_controller=true}
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
    if self.lives <= 0 then
    end
  end
  function self.level_exist(level)
    if self.level_settings[string.format("level%02d", level)] == nil then
      return false
    else
      return true
    end
  end
  function self.update(dt)
    self.ship.update(dt)
  end
  function self.draw()
    self.ship.draw()
  end

  return self
end