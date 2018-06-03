local suit = require "ext/suit"

require "helpers"

HistoryScreen = {}

function HistoryScreen.new()
  local self = {}
  self.text_speed = -20
  self.position = 0
  self.history = {}
  self.history.texts = {}

  for i=1, 65 do
    local key = string.format("history_part_%02d",i)
    self.history.texts[#self.history.texts+1] = translation_of_key(key)
  end

  self.ui = suit.new()

  function self.reset_histories()
    self.position = HEIGHT
  end

  function self.update_position(dt)
    local new_position = self.position + dt * self.text_speed
    self.position = new_position
    return new_position
  end

  function self.key_events(key)
    if key == settings.players_settings.player_01_keys.shoot then
      go_to_main_menu_screen()
    end
  end

  function self.update(dt)
    set_game_font_to('black', 'big')
    local screen_distance = 50
    local label_width = WIDTH - (screen_distance*2)
    local label_height = 50
    local y = self.position
    for _, text in pairs(self.history.texts) do
      self.ui:Label(text, screen_distance, y, label_width, label_height)
      y = y + label_height
    end

    self.update_position(dt)
  end

  function self.draw()
    -- explosion_animation.draw{x=100, y=100, rot=0, scala_x=1, scala_y=1}
    self.ui:draw()
  end

  self.reset_histories()

  return self
end
