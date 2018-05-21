local suit = require "ext/suit"
require "ship_information"

SelectShipMenu = {}

function SelectShipMenu.new(args)
  local self = Class.new()
  self.inherit(Menu.new(args))

  self.ship_information_positions =
  {
    player_01 =
    {
      x = WIDTH / 8,
      y = HEIGHT / 4
    },
    player_02 =
    {
      x = (WIDTH / 8) * 5,
      y = HEIGHT / 4
    }
  }

  self.ship_informations = {}

  function self.key_events(key)
    if key == 'space' and #self.ship_informations < PLAYER_LIMIT then
      self.add_player('player_02')
      return
    end

    local player_one_info = self.ship_informations[1]
    local player_two_info = self.ship_informations[2]

    if player_one_info ~= nil then
      if not player_one_info.ready then
        if key == 'left' then
          player_one_info.back_ship()
        end
        if key == 'right' then
          player_one_info.next_ship()
        end
      end
      if key == 'return' then
        self.player_ready('player_01')
      end
    end

    if player_two_info ~= nil then
      if not player_two_info.ready then
        if key == 'a' then
          player_two_info.back_ship()
        end
        if key == 'd' then
          player_two_info.next_ship()
        end
      end
      if key == 'space' then
        self.player_ready('player_02')
      end
    end
  end

  function self.go_to_game_screen()
    CURRENT_SCREEN = SCREENS.GAME_SCREEN
  end

  function self.play()
    if self.all_players_ready() then
      for i, ship_information in ipairs(self.ship_informations) do
        game_controller.create_player(i, ship_information.current_model_name())
      end
      game_controller.start_game()
    else

    end
    self.go_to_game_screen()
  end

  function self.selected_ship_of_player(player)
    for _, ship_information in ipairs(self.ship_informations) do
      if ship_information.owner == player then
        return ship_information.type
      end
    end
    return nil
  end

  function self.all_players_ready()
    for _, ship_information in ipairs(self.ship_informations) do
      if not ship_information.ready then
        return false
      end
    end
    return true
  end

  function self.player_ready(player)
    for _, ship_information in ipairs(self.ship_informations) do
      if ship_information.owner == player then
        ship_information.ready = not ship_information.ready
      end
    end
  end

  function self.add_player_information_menu(player)
    local ships_information = {}
    for name, ship_info in pairs(game_controller.ship_models) do
      local new_ship_information = {}
      new_ship_information.type = name
      new_ship_information.sprite = ship_sprites[name].center
      new_ship_information.hp = ship_info.max_hp
      new_ship_information.speed = ship_info.speed
      new_ship_information.defense = ship_info.defense
      table.insert(ships_information, new_ship_information)
    end
    local x = self.ship_information_positions[player].x
    local y = self.ship_information_positions[player].y
    local ship_information = ShipInformation.new{ships_informations=ships_information,
                                                owner=player,
                                                 x=x,
                                                 y=y}
    table.insert(self.ship_informations, ship_information)
  end

  function self.add_player(player)
    self.add_player_information_menu(player)
  end

  function self.update()
    love.graphics.setFont(fonts.normal)
    local button_heigh = 40
    local buttons_width = 120
    local button_space = 5
    local x = self.x - (buttons_width/2)
    local y = self.y - ((button_heigh*#self.options)/2)

    for i, option in ipairs(self.options) do
      if option.type == 'button' then
        if self.ui:Button(option.text, x, y, buttons_width, button_heigh).hit then
          if option.method ~= nil then option.method() end
        end
      elseif option.type == 'label' then
        self.ui:Label(option.text, x, y, buttons_width, button_heigh)
      elseif option.type == 'slider' then
        local status = self.ui:Slider(option, x, y, buttons_width, button_heigh)
        if option.text ~= '' then
          local temp_text = option.text..': '..around(option.value)
          self.ui:Label(temp_text, x+buttons_width, y, buttons_width, button_heigh)
        end
        if status.changed and option.method then
          option.method(option.value)
        end
      end
      y = y + button_heigh + button_space
    end

    for _, ship_information in ipairs(self.ship_informations) do
      ship_information.update(dt)
    end
  end

  function self.draw()
    for i, ship_information in ipairs(self.ship_informations) do
      ship_information.draw()
    end
    self.ui:draw()
  end

  self.add_player('player_01')

  -- add the title of this menu
  self.add_label('game_options_04')
  -- button to go to game
  self.add_button('game_options_01', self.play)

  return self
end