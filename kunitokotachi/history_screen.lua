local suit = require "ext/suit"

require "helpers"

HistoryScreen = {}

function HistoryScreen.new()
  local self = {}

  self.min_time_to_next_text_part = 1
  self.time_to_next_text_part = 0.3
  self.time_to_next_image_part = 0.35
  self.time_to_next_part = 0
  self.current_time_to_next_part = 0

  self.current_presentation_id = 1
  self.current_presentation_part_id = 1

  self.music_started = false

  self.current_presentation_image_to_show = nil

  local spt = cut_scenes_sprites

  self.presentation_order =
  {
    {"history_part_01"},
    {spt[1][1], spt[1][2], spt[1][3], spt[1][4], spt[1][5], spt[1][6]},
    {spt[2][1], spt[2][2], spt[2][3], spt[2][4], spt[2][5]},
    {"history_part_02", "history_part_03"},
    {spt[3][1]},
    {"history_part_04"},
    {spt[4][1], spt[4][3], spt[4][2]},
    {"history_part_06"},
    {spt[4][4]},
    {"history_part_10", "history_part_11", "history_part_13"},
    {spt[5][1]},
    {"history_part_16"},
    {spt[6][1]},
    {"history_part_17","history_part_18", "history_part_19"},
    {"history_part_20", "history_part_21"},
    {spt[7][1]},
    {"history_part_22", "history_part_23", "history_part_24", "history_part_25"},
    {spt[8][1]},
    {"history_part_27", "history_part_28", "history_part_29", "history_part_30"},
    {spt[8][2]},
    {"history_part_31", "history_part_32", "history_part_33"},
    {spt[8][3]},
    {"history_part_34", "history_part_36", "history_part_37"},
    {spt[9][1]},
    {"history_part_38", "history_part_39", "history_part_40", "history_part_41", "history_part_42", "history_part_43", "history_part_44"},
    {spt[8][1]},
    {"history_part_45", "history_part_46", "history_part_57"},
    {spt[8][1]},
    {"history_part_58", "history_part_59"},
    {"history_part_60", "history_part_61", "history_part_62"}

  }

  function self.reset_histories()
    self.music_started = false
    self.current_time_to_next_part = 0
    self.current_presentation_id = 1
    self.current_presentation_part_id = 1
    self.current_presentation_image_to_show = nil
    moan.advanceMsg()
  end

  function self.count_words_by_spaces(phrase)
    local space_count = 0
    local space_reached = fase

    for letter_id=1, #phrase, 1 do
      local character = phrase:sub(letter_id, letter_id)
      if character == ' ' then
        if not space_reached then
          space_reached = true
          space_count = space_count + 1
        end
      else
        space_reached = false
      end
    end
    return space_count
  end

  function self.current_presentation()
    return self.presentation_order[self.current_presentation_id]
  end

  function self.current_presentation_part()
    return self.current_presentation()[self.current_presentation_part_id]
  end

  function self.update_time_to_next_part(dt)
    self.current_time_to_next_part = self.current_time_to_next_part + dt
  end

  function self.current_presentation_part_times_up()
    return self.current_time_to_next_part > self.time_to_next_part
  end

  function self.go_to_next_presentation()
    self.current_presentation_id = self.current_presentation_id + 1
    self.current_presentation_part_id = 1
  end

  function self.go_to_next_presentation_part()
    self.current_presentation_part_id = self.current_presentation_part_id + 1
  end

  function self.next_moan_message()
    moan.advanceMsg()
  end

  function self.reset_current_time()
    self.current_time_to_next_part = 0
  end

  function self.show_presentation_part()
    local presentation_type = type(self.current_presentation_part())
    if presentation_type == 'string' then
      local message = translation_of_key(self.current_presentation_part())
      local character_name = translation_of_key("unknown_character")
      local amount_of_extra_time = self.count_words_by_spaces(message)
      self.time_to_next_part = self.min_time_to_next_text_part + self.time_to_next_text_part * amount_of_extra_time
      moan.speak(character_name, {message}, {image=avatars.no_signal.normal})
    elseif presentation_type == 'table' then
      self.time_to_next_part = self.time_to_next_image_part
      self.current_presentation_image_to_show = self.current_presentation_part()
    end
  end

  function self.key_events(key)
    if key == settings.players_settings.player_01_keys.shoot then
      sfx_controller.stop_all_sounds()
      moan.advanceMsg()
      go_to_main_menu_screen()
    end
  end

  function self.update(dt)
    if not self.music_started then
      sfx_controller.play_sound('intro')
      self.music_started = true
    end
    set_game_font_to('black', 'big')

    if self.current_presentation_part_times_up() then
      self.reset_current_time()
      self.next_moan_message()
      -- self.current_presentation_image_to_show = nil
      if self.current_presentation() ~= nil then
        self.show_presentation_part()
        self.go_to_next_presentation_part()
        if self.current_presentation_part() == nil then
          self.go_to_next_presentation()
        end
      else
        self.reset_histories()
        sfx_controller.stop_all_sounds()
        go_to_main_menu_screen()
        return
      end
    else
      self.update_time_to_next_part(dt)
    end
  end

  function self.draw()
    if self.current_presentation_image_to_show ~= nil then
      local sprite = self.current_presentation_image_to_show
      local sprite_width, sprite_height = sprite.image:getDimensions()
      sprite.draw{x=0+sprite_width/2,
                  y=0+sprite_height/2,
                  scala_x=1,
                  scala_y=1,
                  rot=0}
    end
  end

  self.reset_histories()

  return self
end
