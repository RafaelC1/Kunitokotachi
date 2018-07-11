local suit = require "ext/suit"

FinalScoreScreen = {}

function FinalScoreScreen.new()
  local self = {}

  self.name_max_size = 4
  self.limit_of_records = 10

  self.players = {}

  self.ui = suit.new()

  function self.reset()
    self.players = {}
  end

  function self.prepare_old_records()
    for i, old_record in pairs(settings.scores.score) do
      self.players[i] = {}
      self.players[i].name = { text=old_record.name }
      self.players[i].score = old_record.score
      self.players[i].keys = {}
      self.players[i].old_record = true
    end
  end

  function self.add_player_to_score(player_info)
    -- get only the necessary informations
    local player = {}
    player.name = { text=player_info.name }
    player.score = player_info.score
    player.keys = player_info.keys
    player.old_record = false

    self.players[#self.players+1] = player
  end

  function self.organize_high_scores(score_table)
    local new_score_table = {}
    local new_score_table_with_limit = {}

    new_score_table[1] = score_table[1]
    table.remove(score_table, 1)

    for i, old_record in ipairs(score_table) do
      for j, new_record in ipairs(new_score_table) do
        if old_record.score > new_record.score then
          table.insert(new_score_table, j, old_record)
          break
        elseif j == #new_score_table then
          table.insert(new_score_table, j+1, old_record)
          break
        end
      end
    end

--     score_screen_01
-- score_screen_02
-- score_screen_03

    for i, record in ipairs(new_score_table) do
      if i > self.limit_of_records then
        break
      end
      new_score_table_with_limit[i] = record
    end

    return new_score_table_with_limit
  end

  function self.organize_all_records_positions()
    self.players = self.organize_high_scores(self.players)
  end

  function self.check_text_size(text_table)
    if #text_table.text > self.name_max_size then
      local resized_name = ''
      for i=1, self.name_max_size, 1 do
        resized_name = resized_name..text_table.text:sub(i, i)
      end

      text_table.text = resized_name
    end
  end

  function self.save_score()
    local organized_score_to_save = {}
    organized_score_to_save.score = {}
    for i, new_record in ipairs(self.players) do
      organized_score_to_save.score[i] = {}
      organized_score_to_save.score[i].name = new_record.name.text
      organized_score_to_save.score[i].score = new_record.score
    end

    settings:save_player_score(organized_score_to_save)
  end

  function self.draw_final_score_of(player, position, x, y)

    local input_text_width = 50
    local label_width = 200
    local label_height = 50

    local total_list_item_width = 0

    position = string.format("%1d°", position)
    self.ui:Label(position, x, y, input_text_width, label_height)

    x = x + input_text_width
    total_list_item_width = total_list_item_width + input_text_width

    if player.old_record then
      self.ui:Label(player.name.text, x, y, input_text_width, label_height)
    else
      self.ui:Input(player.name, {},x, y, input_text_width, label_height)
    end

    x = x + input_text_width

    total_list_item_width = total_list_item_width + input_text_width

    local final_score_text = string.format("%s: %010d", translation_of_key('score_screen_02'), player.score)
    self.ui:Label(final_score_text, x, y, label_width, label_height)

    total_list_item_width = total_list_item_width + label_width

    return (y + label_height), total_list_item_width
  end

  function self:key_events(key)
    self.ui:keypressed(key)
  end

  function love.textedited(text, start, length)
    self.ui.textedited(text, start, length)
  end

  function love.textinput(t)
    self.ui:textinput(t)
  end

  function self:update(dt)

    do
      set_game_font_to('black', 'extra_big')

      local label_width = 200
      local label_height = 50
      local x = WIDTH/2 - label_width/2
      local y = 50 - label_height/2

      local score_title = translation_of_key('score_screen_01')
      self.ui:Label(score_title, x, y, label_width, label_height)
    end
    -- scope for individual scores
    do
      set_game_font_to('black', 'big')

      local x = 100
      local start_y = 100
      local y = start_y
      local colunms = 0
      local amount_per_colum = self.limit_of_records/2
      local field_width = 0

      for i, player in ipairs(self.players) do
        if i > amount_per_colum then
          amount_per_colum = amount_per_colum + 5
          colunms = colunms + 1
          y = start_y
        end
        self.check_text_size(player.name)
        y, field_width = self.draw_final_score_of(player, i, x+field_width*colunms, y)
      end
    end

    do
      local button_width = 200
      local button_height = 50
      local x = WIDTH/2 - button_width/2
      local y = HEIGHT - button_height - button_height/2
      local back_buttom_text = translation_of_key('score_screen_03')
      if self.ui:Button(back_buttom_text, x, y, button_width, button_heigh).hit then
        self.save_score()
        self.reset()
        go_to_main_menu_screen()
      end
    end
  end

  function self.draw()
    self.ui:draw()
  end

  return self
end