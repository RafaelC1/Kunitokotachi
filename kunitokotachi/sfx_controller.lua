SfxController = {}

function SfxController.new()
  local self = {}

  self.all_sfx_path = 'res/sfx/'

  self.sound_effects = {}
  self.playing_sound_effects = {}

  self.musics = {}
  self.current_music = nil

  function self:add_sound(sound_name, sound_path)
    -- static to put the sound on memory
    local full_path = self.all_sfx_path..sound_path
    self.sound_effects[sound_name] = love.audio.newSource(full_path, 'static')
  end

  function self:add_music(music_name, music_path)
    local full_path = self.all_sfx_path..music_path
    self.musics[music_name] = love.audio.newSource(full_path, 'static')
  end

  function self:update_all_sounds_volumes(volume)
    for _, sound_effect in pairs(self.sound_effects) do
      sound_effect:setVolume(volume/4)
    end
  end

  function self:update_all_sounds_volumes(volume)
    for _, music in pairs(self.musics) do
      music:setVolume(volume)
    end
    if self.current_music ~= nil then
      self.current_music:setVolume(volume/4)
    end
  end

  function self:update_volumes(sound_volume, music_volume)
    -- volume is between 0 and 1
    sound_volume, music_volume = sound_volume/100, music_volume/100
    self:update_all_sounds_volumes(sound_volume)
    self:update_all_sounds_volumes(music_volume)
  end

  function self:play_sound(sound_name, loop)
    local sound_to_play = self.sound_effects[sound_name]
    if sound_to_play == nil then
      return
    end

    sound_to_play = sound_to_play:clone()
    self.playing_sound_effects[#self.playing_sound_effects+1] = sound_to_play
    sound_to_play:setLooping(loop or false)
    sound_to_play:play()
  end

  function self:stop_all_sounds()
    for i, sound in ipairs(self.playing_sound_effects) do
      sound:stop()
    end
    self.playing_sound_effects = {}
  end

  function self:update(dt)
    for i, sound in ipairs(self.playing_sound_effects) do
      if not sound:isPlaying() then
        table.remove(self.playing_sound_effects, i)
      end
    end
  end

  return self
end