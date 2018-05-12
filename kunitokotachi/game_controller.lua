require "player"
require "ship"
require "helpers"
require "assets_loader"

GameController = {}

function GameController.new()
  local self = {}
  self.players = {}
  self.back_menu_time = 0
  self.levels_settings = {}

  self.levels_settings = json_to_table(read_from('res/settings/levels_script.json'))

  self.cenary_speed = 5
  self.current_level = 1
  self.current_level_settings = {}

  self.ship_models = json_to_table(read_from('res/settings/ships.json'))

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

  self.levels_of_player_settings = json_to_table(read_from('res/settings/player_levels_settings.json'))

-- go to next level
  function self.nex_level()
    if self.current_level+1 < #self.levels_settings.levels_names then
      self.current_level = self.current_level + 1
    else
      print('you reach the last level')
    end
  end
  -- update current_level_settings informations based on current level
  function self.update_current_level()
    self.current_level_settings = {}
    self.current_level_settings.name = self.levels_settings.levels_names[self.current_level]
    self.current_level_settings.current_script = self.levels_settings[self.current_level_settings.name]
    self.current_level_settings.current_position = HEIGHT - level_background_images[self.current_level_settings.name]:getHeight()
    -- reset all events to they become unwsed
    for i, script in ipairs(self.current_level_settings.current_script.triggers) do
      script[6] = false
    end
  end
-- this method check if in the current position controller should spawn something
  function self.check_level_script()
    local correct_position = level_background_images[self.current_level_settings.name]:getHeight() + self.current_level_settings.current_position
    -- print(correct_position)
    for i, script in ipairs(self.current_level_settings.current_script.triggers) do
      -- if the iteration get a line with a posiiton trigget highets than the current, stop iteration
      if script[1] > correct_position then return end
        -- check if event was not actived already
        if not script[6] then
          local enemy_names = enemies_controller.all_enemy_names()
          local asteroid_names = enemies_controller.all_asteroid_names()
        -- check if event name is to spawn a enemy based on event secound value wich, if its a spawn of a enemy, will be its name
          if array_include_value(enemy_names, script[2]) then
            enemies_controller.create_enemy(script[3], script[4], script[2], script[5])
            -- check if event name is to spawn some asteroid
          elseif array_include_value(asteroid_names, script[2]) then
            enemies_controller.create_asteroid(script[3], script[4], script[2])
          else
            print("event dont identified")
          end
      end
      script[6] = true
    end
  end
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
  -- this method check if a list of objects collider againsts another one
  function self.objects_collide_against(objects_1, objects_2)
    for i, object_1 in ipairs(objects_1) do
      for j, object_2 in ipairs(objects_2) do
        if touch_each_other(object_1, object_2) and not object_1.invulnerable and not object_2.invulnerable then
          object_1.apply_damage(object_2.current_hp)
          object_2.apply_damage(object_1.current_hp)
        end
      end
    end
  end
  -- this method check if player collected(touched) some power up and collect it
  function self.check_collect_power_up(player, power_ups)
    for i, power_up in ipairs(power_ups) do
      if touch_each_other(player, power_up) then
        player.collect_power_up(power_up.power)
        power_ups_controller.destroy_power_up(i)
        i = i-1
      end
    end
  end
  -- check of some object hitted a bullet
  function self.object_hit_a_bullet(object, bullet_hitted)
    if not object.invulnerable then
      object.apply_damage(bullet_hitted.damage)
      if not object.is_alive() and object.give_bonus and bullet_hitted.owner ~= nil then
        bullet_hitted.who_shooted().earn_points(object.give_bonus())
      end
    end
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
    local keys = settings['players_settings']['player'..player]
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
    -- reset controllers
    enemies_controller.destroy_all_enemies()
    enemies_controller.destroy_all_asteroids()
    bullets_controller.destroy_all_bullets()

    self.current_level = 1
    self.update_current_level()
    -- when game is started anything most be reseted
    for i=1, amountOfPlayers do
      self.create_player(i, {x=self.spawn_pos[string.format("player%d",i)].x, y=self.spawn_pos[string.format("player%d",i)].y})
    end
    -- self.current_level_settings = self.levels_settings[string.format("level%02d",self.current_level)]
  end
  -- end a game
  function self.end_game()
    -- when game is ended, all players must be destroyed and yours scores saved
    -- after this method be called, should be show players score
  end
  function self.go_to_menu()
    CURRENT_SCREEN = SCREENS.MAIN_MENU_SCREEN
  end
  function self.lose_message()
    messages =
    {
      translation_of_key('Higuchi_dying_message_01'),
      translation_of_key('Higuchi_dying_message_02'),
      translation_of_key('Higuchi_dying_message_03')
    }
    show_dialog{name='Higuchi', messages=messages, action=self.go_to_menu}
  end
  -- move map
  function self.inscrease_position(dt)
    self.current_level_settings.current_position = self.current_level_settings.current_position + self.cenary_speed*dt
  end
  function self.update(dt)
    local ships = {}
    local anyone_alive = false
    for i, player in ipairs(self.players) do
      player.update(dt)
      -- check if player is alive to make logic
      if player.ship_is_alive() then
        ships[#ships+1] = player.ship
        if player.ship.self_controller then
          self.controll_player(player, dt)
        end
        if power_ups_controller.has_power_ups then
          self.check_collect_power_up(player.ship, power_ups_controller.power_ups)
        end
      elseif next(player.ship) then
        player.die()
      end
      if player.has_extra_lives() then
        anyone_alive = true
      end
    end

    bullets_controller.update(dt)
    enemies_controller.update(dt)
    power_ups_controller.update(dt)
    explosions_controller.update(dt)

    -- player against bullet
    if bullets_controller.has_player_bullets() then
      self.check_bullet_hit(bullets_controller.bullets.player, enemies_controller.enemies)
    end
    -- enemy against bullet
    if bullets_controller.has_enemy_bullets() then
      self.check_bullet_hit(bullets_controller.bullets.enemy, ships)
    end
    -- ship agains enemy
    if enemies_controller.has_enemies() and #ships > 0 then
      self.objects_collide_against(ships, enemies_controller.enemies)
    end
    -- player against asteroid
    if enemies_controller.has_asteroids and #ships > 0 then
      self.objects_collide_against(ships, enemies_controller.asteroids)
    end
    -- player bullets against asteroid
    if enemies_controller.has_asteroids and bullets_controller.has_player_bullets then
      self.check_bullet_hit(bullets_controller.bullets.player, enemies_controller.asteroids)
    end
    -- enemy bullet against asteroid
    if enemies_controller.has_asteroids and bullets_controller.has_enemy_bullets then
      self.check_bullet_hit(bullets_controller.bullets.enemy, enemies_controller.asteroids)
    end

    if self.current_level_settings.current_position <= 0 then
      self.inscrease_position(dt)
    end
    if not anyone_alive then
      explosions_controller.destroy_all_explosions()
      self.go_to_menu()
    end

    self.check_level_script()
  end
  function self.draw()
    -- draw background
    -- love.graphics.draw(level_background_images[self.current_level_settings.name] , 0, self.current_level_settings.current_position)
    enemies_controller.draw()
    bullets_controller.draw()
    power_ups_controller.draw()
    explosions_controller.draw()
    -- draw player GUI
    for i, player in ipairs(self.players) do
      -- draw player
      player.draw()

      local screen_distance = 25
      local pos = self.player_gui_pos['player'..player.player]
      local text = 'power:'..(player.ship.power or 0)
      love.graphics.print(text, pos.x+screen_distance*(i-1), HEIGHT-60)
      -- draw lives on bottom of screen
      for i=1, player.lives do
        print((pos.x+screen_distance*(i-1)))
        life_sprite.draw{x=(pos.x+screen_distance*(i-1)),
                         y=HEIGHT-35}
      end
      -- draw player score
      local scoreText = string.format("%s score: %010d", player.name, player.score)
      local text = love.graphics.newText(fonts.black, scoreText)
      love.graphics.draw(text, screenDistance, screenDistance)
    end
  end

  return self
end
