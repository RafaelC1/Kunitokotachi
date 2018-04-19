require "helpers"

HistoryScreen = {}

function HistoryScreen.new()
  local self = {}
  self.i = 100
  self.text = {}
  self.text.current_text = 0
  self.text.message_is_going = false
  self.text.name = translation_of_key('history_narrator')
  self.text.history_parts =
  {
    {
      back_ground = '',
      text =
      {
        translation_of_key('history_narrator'),
        translation_of_key('history_part_02'),
        translation_of_key('history_part_03'),
        translation_of_key('history_part_04'),
        translation_of_key('history_part_05'),
        translation_of_key('history_part_06'),
        translation_of_key('history_part_07'),
        translation_of_key('history_part_08'),
        translation_of_key('history_part_09'),
        translation_of_key('history_part_10'),
      }
    }
  }

  function self.reset_histories()
    self.text.current_text = 0
  end

  function self.go_to_main_menu()
    CURRENT_SCREEN = SCREENS.MAIN_MENU_SCREEN
  end

  function self.next_message()
    self.text.current_text = self.text.current_text + 1
  end

  function self.show_message(message_id)
    show_dialog{name=self.text.name, messages=self.text.history_parts[message_id].text, action=self.message_endend}
  end

  function self.message_started()
    self.text.message_is_going = true
  end

  function self.message_endend()
    self.text.message_is_going = false
  end

  function self.update(dt)
    if not self.text.message_is_going then
      self.next_message()
      if self.text.current_text > #self.text.history_parts then
        self.go_to_main_menu()
        self.reset_histories()
        return
      end
      self.show_message(self.text.current_text)
      self.message_started()
    end
    explosions_controller.update(dt)
  end

  function self.draw()
    -- explosion_animation.draw{x=100, y=100, rot=0, scala_x=1, scala_y=1}
    explosions_controller.draw()
  end

  return self
end