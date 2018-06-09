require "assets_loader"
require "helpers"
require "player"
require "ship"
local suit = require "ext/suit"

GameController = {}

function GameController.new()
  local self = {}
  self.pause = false
  self.current_messages_amount = 0

  self.ui = suit.new()

  self.players = {}
  self.back_menu_time = 0
  self.levels_settings = {}

  local levels_script_path = "levels_script.json"
  if file_exist(levels_script_path) then
    self.levels_settings = json_to_table(read_from(levels_script_path))
  else
    self.levels_settings = json_to_table(read_from('res/settings/levels_script.json'))
  end


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

  self.go_to_menu_delay = 3
  self.go_to_menu_current_delay = 0

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
    self.current_level_settings.boss_spawned = false
    self.current_level_settings.boss_killed = false
    self.current_level_settings.name      = self.levels_settings.levels_names[self.current_level]
    local name_to_find_by                 = self.current_level_settings.name
    self.current_level_settings.speed     = self.levels_settings[name_to_find_by].speed
    self.current_level_settings.script    = self.levels_settings[name_to_find_by].script.enemy_triggers
    self.current_level_settings.position  = HEIGHT -- set 1X width to make sure that the first back sprite appear
    self.current_level_settings.length    = self.levels_settings[name_to_find_by].length
    -- reset all events to they become unwsed
    for i, script in ipairs(self.current_level_settings.script) do
      script[6] = false
    end
  end
-- this method check if in the current position controller should spawn something
  function self.check_level_script()
    local correct_position = self.current_level_settings.position
    for i, script in ipairs(self.current_level_settings.script) do
      local position = script[1]
      local event_name = script[2]
      local already_activated = script[6]
        -- check if event was not actived already
      if not already_activated then
      -- if the iteration get a line with a posiiton trigget highets than the current, stop iteration
        if position > correct_position then return end
          local enemy_names = enemies_controller.all_enemy_names()
          local asteroid_names = enemies_controller.all_asteroid_names()
          local boss_names = enemies_controller.all_boss_names()
        -- check if event name is to spawn a enemy based on event secound value wich, if its a spawn of a enemy, will be its name
          -- spawn enemy by checking if event name is one of the enemies name
          if array_include_value(enemy_names, event_name) then
            local width = script[3]
            local drop = script[4]
            local behaviour = script[5]
            enemies_controller.create_enemy(width, height, event_name, behaviour, drop)
          -- spawn asteroid by checking if event name is one of the asteroids name
          elseif array_include_value(asteroid_names, event_name) then
            local width = script[3]
            local height = script[4]
            local behaviour = script[5]
            enemies_controller.create_asteroid(width, height, event_name)
          elseif array_include_value(boss_names, event_name) then
            local width = script[3]
            local height = script[4]
            local behaviour = script[5]
            -- kill all enemies when boss spawn
            enemies_controller.destroy_all_enemies()
            enemies_controller.create_enemy(WIDTH/2, -100, event_name, behaviour)
          elseif event_name == 'message' then
            local title = script[3]

            local messages = {}
            for i, translation in ipairs(script[4]) do
              messages[#messages+1] = translation_of_key(translation)
            end

            local character = script[5]
            local avatar = avatars[character[1]][character[2]]
            self.pause = true
            self.current_messages_amount = #messages
            moan.speak(title, messages, { image=avatar })
            -- print("event dont identified")
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
        if touch_each_other(object_1, object_2) and not object_1:is_invulnerable() and not object_2:is_invulnerable() then
          object_1.apply_damage(object_2.current_hp)
          object_2.apply_damage(object_1.current_hp)
        end
      end
    end
  end
  -- this method check if player collected(touched) some power up and collect it
  function self.check_collect_power_up(ship, power_ups)
    for i, power_up in ipairs(power_ups) do
      if touch_each_other(ship, power_up) then
        ship.collect_power_up(power_up.power)
        power_ups_controller.destroy_power_up(i)
        i = i-1
      end
    end
  end
  -- check of some object hitted a bullet
  function self.object_hit_a_bullet(object, bullet_hitted)
    if not object:is_invulnerable() then
      object.apply_damage(bullet_hitted.damage)
      -- this call is only for enemies that will blink blank for a time if they are attack
      -- until i discovrey a betther way to do this, it will be in here
      if object.blink_blank_by_hit ~= nil then
        object.blink_blank_by_hit()
      end
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
  function self.create_player(player, ship_model)
    local keys = settings['players_settings']['player_0'..player..'_keys']
    local x = self.spawn_pos['player'..player].x
    local y = self.spawn_pos['player'..player].y
    local character = Player.new(player, keys, self.levels_of_player_settings)
    character.ship_model = ship_model
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
  function self.start_game()
    -- reset controllers
    self.current_level = 1
    self.reset_all_controllers()
    self.update_current_level()
  end

  function self.reset_all_controllers()
    enemies_controller.destroy_all_enemies()
    enemies_controller.destroy_all_asteroids()
    bullets_controller.destroy_all_bullets()
    power_ups_controller.destroy_all_power_ups()
    explosions_controller.destroy_all_explosions()
  end
  -- end a game
  function self.end_game()
    self.reset_all_controllers()
    self.players = {}
    go_to_main_menu_screen()
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
  function self.current_level_get_to_the_end()
    -- this -HEIGHT/2 is to adjuste the correct position that need to be checked sence we are
    -- couting from the middle of the screen
    return self.current_level_settings.position < self.current_level_settings.length - HEIGHT/2
  end
  -- move map
  function self.inscrease_position(dt)
    local new_position = self.current_level_settings.position + self.current_level_settings.speed*dt
    self.current_level_settings.position = new_position
    return new_position
  end

  function self.update_level(dt)
    if self.current_level_get_to_the_end() then
      self.inscrease_position(dt)
      self.check_level_script()
    end
  end

  function self.key_events(key)
    local next_moan_key = 'space'
    if key == next_moan_key then
      if self.current_messages_amount > 0 then
        self.current_messages_amount = self.current_messages_amount - 1
      end
      if self.current_messages_amount <= 0 then
        self.pause = false
      end
    end
  end

  function self.update(dt)

    if self.pause then
      return
    end

    set_game_font_to('black', 'normal')
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
      elseif player.ship then
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

    -- this logic bellow is for check if boss was killed and level ended
    if self.current_level_settings.boss_spawned then
      -- after boss spawn, all enemies are destoryed so, the last one is the boss
      -- and if the enemeis count go zero, it means that boss was killed
      if not enemies_controller.has_enemies then
        self.current_level_settings.boss_spawned = false
        self.current_level_settings.boss_killed = true
        -- END LEVEL
      end
    end

    if not anyone_alive then
      self.go_to_menu_current_delay = self.go_to_menu_current_delay + dt
      if self.go_to_menu_current_delay > self.go_to_menu_delay then
        self.go_to_menu_current_delay = 0
        self.end_game()
      end
    end
    self.update_level(dt)
  end

  function self.back_ground_can_be_draw(back_ground, correct_position)
    local can_draw = false
    -- the extra "HEIGHT" add and subtract is to allow that multiple sprites (3) as showed at
    -- same time to make as it was a single sprite with all image but, on the reallity are just
    -- rendering 3 images, one before the correct, the correct and 1 after it
    if (back_ground.start_y) >= correct_position - HEIGHT and
       correct_position + HEIGHT >= (back_ground.start_y - back_ground.quad_height) then
       can_draw = true
    end
    return can_draw
  end

  function self.current_play_charger_hud(player)
      return hud_bar_sprites['charge_lvl_0'..player.ship.current_power_level]
  end

  function self.draw_player_gui(player)
    local button_heigh = 40
    local buttons_width = 120
    local screen_distance = 30
    -- draw player
    local pos = self.player_gui_pos.player1
    local pos_x = pos.x
    local pos_y = pos.y

    -- local pos = self.player_gui_pos['player'..player.player]
    if player.player == 2 then
      pos_x = WIDTH/2
    end

    -- this should be temporary
    if player.ship ~= nil then
      self.current_play_charger_hud(player).draw{x=(pos_x+screen_distance+self.current_play_charger_hud(  player).quad_width/4),
                                                 y=HEIGHT-screen_distance*1.5-life_sprite.quad_height}
    end
    -- draw lives on bottom of screen
    for i=1, player.lives do
      life_sprite.draw{x=(pos_x+screen_distance*i), y=HEIGHT-screen_distance*1.5}
    end
    -- draw player score
    set_game_font_to('black', 'big')
    local scoreText = string.format("%s score: %010d", player.name, player.score)
    self.ui:Label(scoreText, pos_x+screen_distance, screen_distance, buttons_width, button_heigh)
  end

  function self.draw()
    local back_current_y = self.current_level_settings.position
    for i, sprite in ipairs(level_background_sprites.level_01_sprites) do
      local back_current_x = sprite.quad_width/2
      local width, height = sprite.image:getDimensions()
      -- this correct position is the inverse of the current possition acording the
      -- map size or the image size (wich shoud be the same size)
      local correct_position = height - self.current_level_settings.position
      -- this check grante that only 3 sprites are renderized to avoid extra video memory consum
      if self.back_ground_can_be_draw(sprite, correct_position) then
        sprite.draw{x=back_current_x,
                    y=back_current_y,
                    scala_x=1,
                    scala_y=1,
                    rot=0}
      end
      -- subtract the current sprite quad height to adjust the position of the next sprite
        back_current_y = back_current_y - sprite.quad_height
    end

    enemies_controller.draw()
    bullets_controller.draw()
    power_ups_controller.draw()

    -- draw player GUI
    for _, player in ipairs(self.players) do
      self.draw_player_gui(player)
      player.draw()
    end

    explosions_controller.draw()
    self.ui:draw()
  end

  return self
end
