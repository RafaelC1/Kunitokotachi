SettingsMenu = {}

function SettingsMenu.new(args)
  local self = Class.new()
  self.inherit(Menu.new(args))

  self.editing_player_settings = false

  self.curret_player_to_edit_key = ''
  self.current_key_to_edit = ''

  self.player_01_settings_sub_menu = Menu.new{ x=(WIDTH/2)/2, y=HEIGHT/2 }
  self.player_02_settings_sub_menu = Menu.new{ x=(WIDTH/2)/2, y=HEIGHT/2 }

  function self.edit_player_controllers()
    self.editing_player_settings = true
  end

  function self.back_to_main_settings()
    self.editing_player_settings = false
  end

  function self.select_key_to_edit(player, key)
    self.current_key_to_edit = key
    self.curret_player_to_edit_key = player
  end
  -- keys manager
  function self.key_events(key)
    if self.editing_player_settings then
      settings.set_player_key(self.curret_player_to_edit_key, self.current_key_to_edit, key)
    end
  end
  -- overwrithing
  self.overwrite('update')
  function self.update()
    if self.editing_player_settings then
      self.player_01_settings_sub_menu.update()
      self.player_02_settings_sub_menu.update()
    else
      self.super('update')
    end
  end

  function self.draw()
    if self.editing_player_settings then
      self.player_01_settings_sub_menu.ui:draw()
      self.player_02_settings_sub_menu.ui:draw()
    else
      self.ui:draw()
    end
  end


  self.player_01_settings_sub_menu.add_button('player_settings_sub_menu_01',
                                                            self.select_key_to_edit('player_01', 'up'))
  self.player_01_settings_sub_menu.add_button('player_settings_sub_menu_02',
                                                            self.select_key_to_edit('player_01', 'down'))
  self.player_01_settings_sub_menu.add_button('player_settings_sub_menu_03',
                                                            self.select_key_to_edit('player_01', 'left'))
  self.player_01_settings_sub_menu.add_button('player_settings_sub_menu_04',
                                                            self.select_key_to_edit('player_01', 'right'))
  self.player_01_settings_sub_menu.add_button('player_settings_sub_menu_05',
                                                            self.select_key_to_edit('player_01', 'shoot'))
  self.player_01_settings_sub_menu.add_button('settings_options_04',
                                                            self.back_to_main_settings)

  return self
end