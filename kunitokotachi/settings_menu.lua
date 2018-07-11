SettingsMenu = {}

function SettingsMenu.new(args)
  local self = Class.new()
  self.inherit(Menu.new(args))

  self.editing_player_settings = false
  self.current_player_to_edit_key = nil
  self.current_key_to_change = 1

  self.player_01_settings_sub_menu = Menu.new{ x=(WIDTH/2)/2, y=HEIGHT/2 }
  self.player_02_settings_sub_menu = Menu.new{ x=3*(WIDTH/2)/2, y=HEIGHT/2 }

  function self.start_edit_keys(player_to_edit)
    if self.current_player_to_edit_key ~= nil then
      return
    end
    self.current_player_to_edit_key = player_to_edit
    self.edit_keys = true
  end

  function self.edit_player_controllers()
    self.editing_player_settings = true
  end

  function self.back_to_main_settings()
    if self.current_player_to_edit_key ~= nil then
      return
    end
    self.editing_player_settings = false
  end
  -- keys manager
  function self.key_events(key)
    if self.current_player_to_edit_key ~= nil then
      local keys = {'up', 'down', 'left', 'right', 'shoot'}
      settings.set_player_key(self.current_player_to_edit_key, keys[self.current_key_to_change], key)
      self.current_key_to_change = self.current_key_to_change + 1

      if self.current_key_to_change > #keys then
        self.current_player_to_edit_key = nil
        self.current_key_to_change = 1
      end
    end
  end
  -- overwrithing
  self.overwrite('update')
  function self:update()
    if self.editing_player_settings then
      self.player_01_settings_sub_menu:update()
      self.player_02_settings_sub_menu:update()
    else
      self:super_update()
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

  local method =
  {
    function()
      return translation_of_key('player_settings_sub_menu_06')..settings.get_player_key('player_01', 'up')
    end,
    function()
      return translation_of_key('player_settings_sub_menu_07')..settings.get_player_key('player_01', 'down')
    end,
    function()
      return translation_of_key('player_settings_sub_menu_08')..settings.get_player_key('player_01', 'left')
    end,
    function()
      return translation_of_key('player_settings_sub_menu_09')..settings.get_player_key('player_01', 'right')
    end,
    function()
      return translation_of_key('player_settings_sub_menu_10')..settings.get_player_key('player_01', 'shoot')
    end,

    function() self.start_edit_keys('player_01') end,
    function ()
      local text = translation_of_key('player_settings_sub_menu_04')
      if self.current_player_to_edit_key == 'player_01' then
        text = text..translation_of_key('player_settings_sub_menu_11')
      end
      return text
    end
  }

  self.player_01_settings_sub_menu.add_label(method[7])
  self.player_01_settings_sub_menu.add_button('player_settings_sub_menu_01', method[6])

  self.player_01_settings_sub_menu.add_label(method[1])
  self.player_01_settings_sub_menu.add_label(method[2])
  self.player_01_settings_sub_menu.add_label(method[3])
  self.player_01_settings_sub_menu.add_label(method[4])
  self.player_01_settings_sub_menu.add_label(method[5])

  self.player_01_settings_sub_menu.add_button('player_settings_sub_menu_05', self.back_to_main_settings)

  method =
  {
    function()
      return translation_of_key('player_settings_sub_menu_06')..settings.get_player_key('player_02', 'up')
    end,
    function()
      return translation_of_key('player_settings_sub_menu_07')..settings.get_player_key('player_02', 'down')
    end,
    function()
      return translation_of_key('player_settings_sub_menu_08')..settings.get_player_key('player_02', 'left')
    end,
    function()
      return translation_of_key('player_settings_sub_menu_09')..settings.get_player_key('player_02', 'right')
    end,
    function()
      return translation_of_key('player_settings_sub_menu_10')..settings.get_player_key('player_02', 'shoot')
    end,

    function() self.start_edit_keys('player_02') end,
    function ()
      local text = translation_of_key('player_settings_sub_menu_04')
      if self.current_player_to_edit_key == 'player_02' then
        text = text..translation_of_key('player_settings_sub_menu_11')
      end
      return text
    end
  }
  self.player_02_settings_sub_menu.add_label(method[7])
  self.player_02_settings_sub_menu.add_button('player_settings_sub_menu_02', method[6])

  self.player_02_settings_sub_menu.add_label(method[1])
  self.player_02_settings_sub_menu.add_label(method[2])
  self.player_02_settings_sub_menu.add_label(method[3])
  self.player_02_settings_sub_menu.add_label(method[4])
  self.player_02_settings_sub_menu.add_label(method[5])

  self.player_02_settings_sub_menu.add_button('player_settings_sub_menu_05', self.back_to_main_settings)

  return self
end