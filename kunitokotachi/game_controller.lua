require "player"
require "ship"
require "helpers"
require "assets_loader"

GameController = {}

function GameController.new()
  local self = {}
  self.players = {}
  self.cenary_speed = 5
  self.back_menu_time = 0
  self.current_level = 1
  self.levels_settings = {}
  self.current_level_settings =
  {
    level_speed = 5,
    current_position = 0,
    enemy_spawn_points =
    {
      x=0,
      y=0
    }
  }
  self.ship_models = {}
  self.levels_of_player_settings = {}

  self.spawn_pos = {}
  self.spawn_pos.player1 = {}
  self.spawn_pos.player2 = {}

  self.spawn_pos.player1.y = HEIGHT + 200
  self.spawn_pos.player1.x = 200
  self.spawn_pos.player2.y = HEIGHT + 200
  self.spawn_pos.player2.x = WIDTH - 200

  self.player_gui_pos = {}
  self.player_gui_pos.player1 = {}
  self.player_gui_pos.player2 = {}
  self.player_gui_pos.player1.x = 10
  self.player_gui_pos.player1.y = HEIGHT - 150
  self.player_gui_pos.player2.x = WIDTH - 85
  self.player_gui_pos.player2.y = HEIGHT - 150



  -- this method check if some bullet from a bullet list hit some object from a object list
  function self.check_bullet_hit(bullets, objects)
    for i, object in ipairs(objects) do
      for j, bullet in ipairs(bullets) do
        if can_touch(object, bullet) then
          if touch_each_other(object, bullet) then
            self.object_hit_a_bullet(object, bullet)
            bullets_controller.destroy_bullet(bullets, j, false)
          end
        end
      end
    end
  end
  -- TERMINAR ISSO
  function self.check_player_hit(player, objects)
    for i, object in ipairs(objects) do
      if can_touch(object, player) then
        if touch_each_other(object, player) then
          -- self.object_hit_a_bullet()
          object.apply_damage{damage=player.hp, aggressor=player}
          player.apply_damage{damage=object.current_hp}
        end
      end
    end
  end
  function self.check_collect_power_up(player, power_ups)
    for i, power_up in ipairs(power_ups) do
      if touch_each_other(object, player) then
        -- self.object_hit_a_bullet()
        object.apply_damage{damage=player.hp, aggressor=player}
        player.apply_damage{damage=object.current_hp}
      end
    end
  end
  function self.object_hit_a_bullet(object, bullet_hitted)
    object.apply_damage{damage=bullet_hitted.damage, agressor=bullet_hitted.owner}
  end
  function self.object_hit_another_object(object1, object2)
    local owner1 = object1.owner or {}
    local owner2 = object2.owner or {}
    object1.apply_damage{damage=object2.current_hp, agressor=owner2}
    object2.apply_damage{damage=object1.current_hp, agressor=owner1}
  end
  function self.object_hit_a_power_up(object1, power_up)
    player_ship.self.collect_power_up(power_up.power)
  end
  -- controll player on its spawn
  function self.controll_player(player, dt)
    local current_y = -player.ship.speed*dt
    player.ship.vertical_move(current_y)
    if player.ship.body.y < 500 then
      player.ship.self_controller = false
    end
  end
  -- generate players
  function self.create_player(player, args)
    local keys = settings['playersSettings']['player'..player]
    local x = self.spawn_pos['player'..player].x
    local y = self.spawn_pos['player'..player].y
    local character = Player.new(player, keys, self.levels_of_player_settings)
    table.insert(self.players, character)
    character.create_ship()
    character.ship.teleport_to(x, y)
  end
  function self.destroy_player(playerID)
    table.remove(self.players, playerID)
    if #self.players <= 0 then
      self.lose_message()
    end
  end
  -- start a game
  function self.start_game(amountOfPlayers)
    -- when game is started anything most be reseted
    for i=1, amountOfPlayers do
      self.create_player(i, {x=self.spawn_pos[string.format("player%d",i)].x, y=self.spawn_pos[string.format("player%d",i)].y})
    end
    -- self.current_level_settings = self.levels_settings[string.format("level%02d",self.current_level)]
    self.current_level_settings.current_position = HEIGHT - level_background_images[string.format("level%02d",self.current_level)]:getHeight()
  end
  -- end a game
  function self.end_game()
    -- when game is ended, all players must be destroyed and yours scores saved
    -- after this method be called, should be show players score
  end
  function self.load_player_level_settings()
    self.levels_of_player_settings = read_values_from('res/settings/player_levels_settings.json')
  end
  -- load ships models
  function self.load_ships_settings()
    self.ship_models = read_values_from('res/settings/ships.json')
  end
  -- read all levels configurations
  function self.load_levels_settings()
    self.levels_settings = read_values_from('res/settings/levels.json')
  end
  function self.go_to_menu()
    current_screen = 2
  end
  function self.lose_message()
    moan.speak('Higuchi',
        {
          translations.translation_of('Higuchi_dying_message_01'),
          translations.translation_of('Higuchi_dying_message_02'),
          translations.translation_of('Higuchi_dying_message_03')
        },
        {x=10, y=10, image=profile_pics.higuchi, oncomplete=self.go_to_menu}
        )
  end
  -- move map
  function self.inscrease_position(dt)
    self.current_level_settings.current_position = self.current_level_settings.current_position + self.current_level_settings.level_speed*dt
  end
  function self.update(dt)
    local ships = {}
    for i, player in ipairs(self.players) do
      player.update(dt)
      -- controll ship when it just spawned
      if player.ship.self_controller then
        self.controll_player(player, dt)
      end
      -- check if player is alive
      if not player.ship.is_alive() then
        player.die()
        -- if player has no lives any more, destroy ship not respawn
        if player.lives <= 0 then
          self.destroy_player(i)
        else
          -- if player has some live, respawn ship
          player.ship.reset()
          self.teleport_player_to_spawn_pos(player)
        end
      end
      ships[i] = player.ship
    end

    bullets_controller.update(dt)
    enemies_controller.update(dt)
    power_ups_controller.update(dt)

    self.check_bullet_hit(bullets_controller.bullets.player, enemies_controller.enemies)
    -- self.bullet_hit(ships)
    if self.current_level_settings.current_position <= 0 then
      self.inscrease_position(dt)
    end
  end
  function self.draw()
    -- draw background
    love.graphics.draw(level_background_images[string.format("level%02d",self.current_level)] , 0, self.current_level_settings.current_position)
    enemies_controller.draw()
    bullets_controller.draw()
    power_ups_controller.draw()
    -- draw player GUI
    for i, player in ipairs(self.players) do
      -- draw player
      player.draw()

      local screenDistance = 25
      local pos = self.player_gui_pos['player'..player.player]
      local text = 'power:'..player.ship.power
      love.graphics.print(text, pos.x+screenDistance*(i-1), HEIGHT-60)
      -- draw lives on bottom of screen
      for i=1, player.lives do
        love.graphics.draw(life_image, pos.x+screenDistance*(i-1), HEIGHT-35)
      end
      -- draw player score
      local scoreText = string.format("%s score: %010d", player.name, player.score)
      local text = love.graphics.newText(fonts.black, scoreText)
      love.graphics.draw(text, screenDistance, screenDistance)
    end
  end

  self.load_player_level_settings()
  self.load_levels_settings()
  self.load_ships_settings()

  return self
end