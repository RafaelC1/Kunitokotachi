require "helpers"

Settings = {}

function Settings.new()
  local self = {}
  self.apllication_settings = {}
  self.players_settings = {}

  function self.set_song_volum(new_volum)
    self.apllication_settings.song_volum = new_volum
  end

  function self.set_music_volum(new_volum)
    self.apllication_settings.music_volum = new_volum
  end
  -- reset all configurations and save the skeleton of score and settings on user save directory
  function self.reset_configurations_and_score()
    love.filesystem.remove('application_settings.json')
    love.filesystem.remove('controllers_settings.json')
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
  -- this method get the skelleton of configurations and save it on user default save directory and start to use it to save status
  function self.initiate_settings()
    local applications_settings_file = 'application_settings.json'
    local controlls_file = 'controllers_settings.json'

    if not file_exist(applications_settings_file) then
      local apllication_settings_default = json_to_table(read_from('configs/application_settings_default.json'))
      self.apllication_settings = self.create_setting_file(applications_settings_file, apllication_settings_default)
    end

    if not file_exist(controlls_file) then
      local players_settings_default = json_to_table(read_from('configs/controllers_settings_default.json'))
      self.players_settings = self.create_setting_file(controlls_file, players_settings_default)
    end

    self.apllication_settings = self.read_settings_of(applications_settings_file)
    self.players_settings = self.read_settings_of(controlls_file)
  end

  self.initiate_settings()

  return self
end