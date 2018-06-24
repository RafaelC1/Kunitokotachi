local suit = require "ext/suit"

FinalScoreScreen = {}

function FinalScoreScreen.new()
  local self = {}
  self.players = {}

  self.ui = suit.new()

  function self.reset()
    self.players = {}
  end

  function self.add_player_to_score(player)
    self.players[#self.players+1] = player
    if self.players[#self.players-1] ~= nil then
      self.players[#self.players].gui_x = 100 + self.players[#self.players-1].gui_x
    else
      self.players[#self.players].gui_x = 100
    end
  end

  function self.draw_final_score_of(player)
    set_game_font_to('black', 'big')
    local x = player.gui_x
    local y = HEIGHT/2
    local final_score_text = string.format("%s score: %010d", player.name, player.score)
    self.ui:Label(final_score_text, x, y, 100, 50)
  end

  function self.key_events(key)
    for _, player in pairs(self.players) do 
      if key == keys.fire.shoot then
        go_to_main_menu_screen()
      end
    end
  end

  function self.update(dt)
    for _, player in pairs(self.players) do 
      self.draw_final_score_of(player)
    end
  end

  function self.draw()
    set_game_font_to('black', 'big')
  end

  return self
end