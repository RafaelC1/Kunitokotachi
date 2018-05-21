local suit = require "ext/suit"

ShipInformation = {}

function ShipInformation.new(args)
  local self = Class.new()

  self.x = args.x
  self.y = args.y

  self.ui = suit.new()

  self.ships_informations = args.ships_informations
  self.current_ship = 1 -- #self.ships_informations
  self.labels = {}

  self.current_informations = {}

  self.owner = args.owner or 'player_01'

  self.ready = false

  function self.current_model_name()
    return self.ships_informations[self.current_ship].type
  end

  function self.current_sprite()
    return self.ships_informations[self.current_ship].sprite
  end

  function self.current_hp()
    return self.ships_informations[self.current_ship].hp
  end

  function self.current_speed()
    return self.ships_informations[self.current_ship].speed
  end

  function self.current_defense()
    return self.ships_informations[self.current_ship].defense
  end

  function self.update_current_informations(new_informations)
    self.current_informations = new_informations
  end

  function self.back_ship()
    if (self.current_ship - 1) < 1 then
      self.current_ship = #self.ships_informations
    else
      self.current_ship = self.current_ship - 1
    end
  end

  function self.next_ship()
    if (self.current_ship + 1) > #self.ships_informations then
      self.current_ship = 1
    else
      self.current_ship = self.current_ship + 1
    end
  end

  function self.add_button(key, method)
    button = { type='button', text='', key=key, method=method }
    self.update_text(button)
    table.insert(self.options, button)
  end

  function self.add_label(key)
    label = { type='label', text='', key=key }
    self.update_text(label)
    table.insert(self.information_labels, label)
  end

  function self.add_slider(min, max, value, step, ...)
    local args = {...}
    args = unpack(args)
    args.key = args.key
    slider = { type='slider', min=min, max=max, value=value, method=args.change_method, step=step, key=args.key, text='' }
    self.update_text(slider)
    table.insert(self.options, slider)
  end

  function self.update_all()
    for i, option in ipairs(self.options) do
      self.update_text(option)
    end
  end

  function self.update_text(widget)
    widget.text = translation_of_key(widget.key)
  end

  function self.update(dt)
    local correct_x = self.x
    local correct_y = self.y + self.current_sprite().quad_height
    local label_width = 100
    local label_height = 20

    self.ui:Label(self.owner, correct_x, correct_y, label_width, label_height)

    correct_y = correct_y + label_height
    for i, label in ipairs(self.labels) do
      self.ui:Label(label.text, correct_x, correct_y, label_width, label_height)
      self.ui:Label(label.value(), correct_x+label_width, correct_y, label_width, label_height)
      correct_y = correct_y + label_height
    end

  -- add message of 'player ready!'
    correct_y = correct_y + label_height
    if self.ready then
      local text = translation_of_key('game_options_08')
      self.ui:Label(text, correct_x, correct_y, label_width, label_height)
    end
  end

  function self.draw()
    local correct_x = self.x + self.current_sprite().quad_width / 2
    local correct_y = self.y + self.current_sprite().quad_height / 2
    self.ui:draw()
    if self.current_sprite() ~= nil then
      self.current_sprite().draw{x=correct_x,
                                 y=correct_y,
                                 scala_x=1,
                                 scala_y=1,
                                 rot=0}
    end
  end

  self.labels =
  {
    {text=translation_of_key('game_options_05'), value=self.current_hp},
    {text=translation_of_key('game_options_06'), value=self.current_speed},
    {text=translation_of_key('game_options_07'), value=self.current_defense},
  }

  return self
 end