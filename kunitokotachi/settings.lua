require "menu"
require "helpers"

Settings = {}

function Settings.new()
  local self = {}

  self.applications_settings_file = 'application_settings.json'
  self.controlls_file = 'controllers_settings.json'
  self.score_file = 'high_scores.json'

  self.apllication_settings = {}
  self.players_settings = {}
  self.scores = {}

  function self.save_all_settings()
    write_values_to(self.applications_settings_file, table_to_json(self.apllication_settings))
    write_values_to(self.controlls_file, table_to_json(self.players_settings))
  end

  function self.save_player_score(new_score)
    write_values_to(self.score_file, table_to_json(new_score))
    self.scores = new_score
  end

  function self.set_song_volum(new_volum)
    self.apllication_settings.song_volum = new_volum
  end

  function self.get_song_volum()
    return self.apllication_settings.song_volum
  end

  function self.set_music_volum(new_volum)
    self.apllication_settings.music_volum = new_volum
  end

  function self.get_music_volum()
    return self.apllication_settings.music_volum
  end
  -- reset all configurations and save the skeleton of score and settings on user save directory
  function self.reset_configurations()
    love.filesystem.remove(self.applications_settings_file)
    love.filesystem.remove(self.controlls_file)
    self.initiate_settings()
  end

  function self.reset_player_score()
    love.filesystem.remove(self.score_file)
    self.initiate_settings()
  end
  -- this method try to find applications already save on this pc, if it doesn't, create one with default
  function self.read_settings_of(file_name)
    if file_exist(file_name) then
      return json_to_table(read_from(file_name))
    else
      return {}
    end
  end

  function self.create_setting_file(file_name, default_values)
    write_values_to(file_name, table_to_json(default_values))
  end
  -- return id of current language
  function self.current_language_id()
    for i, lang in ipairs(self.apllication_settings.languages) do
      if self.apllication_settings.language == lang then
        return i
      end
    end
    return 1
  end
  -- return the current langauge in string
  function self.current_language()
    for i, lang in ipairs(self.apllication_settings.languages) do
      if self.apllication_settings.language == lang then
        return lang
      end
    end
    return 'pt'
  end

  function self.next_language(jump)
    local current_language = self.current_language_id()
    local amount_of_languages = table.getn(self.apllication_settings.languages)
    current_language = current_language+jump
    if current_language > amount_of_languages then
      current_language = 1
    elseif current_language < 1 then
      current_language = amount_of_languages
    end
    self.apllication_settings.language = self.apllication_settings.languages[current_language]
  end
  -- methods bellow belongs to player controller, set/get
  function self.get_player_key(player_owner_of_key, key_name)
    return self.players_settings[player_owner_of_key..'_keys'][key_name]
  end
  -- change player key and, if there is a key using the same value, change it to nil
  function self.set_player_key(player_owner_of_key, key_name, new_key_value)
    local player_owner_of_key_already_in_use, key_already_in_use = self.keyboard_key_already_in_use(new_key_value)
    if key_already_in_use ~= nil then
      self.players_settings[player_owner_of_key_already_in_use][key_already_in_use] = translation_of_key('error_100')
    end
    self.players_settings[player_owner_of_key..'_keys'][key_name] = new_key_value
  end

  function self.keyboard_key_already_in_use(new_key_value)
    local key_already_in_use = nil
    for key, value in pairs(self.players_settings.player_01_keys) do
      if value == new_key_value then
        return 'player_01_keys', key
      end
    end
    for key, value in pairs(self.players_settings.player_02_keys) do
      if value == new_key_value then
        return 'player_02_keys', key
      end
    end

    return nil, nil
  end
  -- this method get the skelleton of configurations and save it on user default save directory and start to use it to save status
  function self.initiate_settings()

    if not file_exist(self.applications_settings_file) then
      local apllication_settings_default = json_to_table(read_from('configs/application_settings_default.json'))
      self.apllication_settings = self.create_setting_file(self.applications_settings_file, apllication_settings_default)
    end

    if not file_exist(self.controlls_file) then
      local players_settings_default = json_to_table(read_from('configs/controllers_settings_default.json'))
      self.players_settings = self.create_setting_file(self.controlls_file, players_settings_default)
    end

    if not file_exist(self.score_file) then
      local player_score_default = json_to_table(read_from('configs/high_score_default.json'))
      self.scores = self.create_setting_file(self.score_file, player_score_default)
    end

    self.apllication_settings = self.read_settings_of(self.applications_settings_file)
    self.players_settings = self.read_settings_of(self.controlls_file)
    self.scores = self.read_settings_of(self.score_file)
  end

  self.initiate_settings()


  return self
end