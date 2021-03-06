local suit = require "ext/suit"
require "helpers"
require "conf"

Menu = {}

local buttonHeigh = 30
local buttonsWidth = 100
local button_space = 5

function Menu.new(args)
  local self = {}

  self.x = args.x or 100
  self.y = args.y or 100

  self.ui = suit.new()

  self.options = {}

  function self.add_button(key, method)
    local button = { type='button', text='', key=key, method=method }
    self:update_text(button)
    table.insert(self.options, button)
  end

  function self.add_label(key)
    local label = { type='label', text='', key=key }
    self:update_text(label)
    table.insert(self.options, label)
  end

  function self.add_slider(min, max, value, step, ...)
    local args = {...}
    args = unpack(args)
    args.key = args.key
    local slider = { type='slider', min=min, max=max, value=value, method=args.change_method, step=step, key=args.key, text='' }
    self:update_text(slider)
    table.insert(self.options, slider)
  end

  function self:update_all()
    for i, option in ipairs(self.options) do
      if type(option.key) == 'string' then
        self:update_text(option)
      elseif type(option.key) == 'function' then
        option.text = option.key()
      end
    end
  end

  function self:update_text(widget)
    widget.text = translation_of_key(widget.key)
  end

  function self:update()
    set_game_font_to('normal', 'normal')
    local button_heigh = 40
    local buttons_width = 120
    local button_space = 5
    local x = self.x - (buttons_width/2)
    local y = self.y - ((button_heigh*#self.options)/2)

    for i, option in ipairs(self.options) do
      if option.type == 'button' then
        if self.ui:Button(option.text, x, y, buttons_width, button_heigh).hit then
          if option.method ~= nil then option.method() end
        end
      elseif option.type == 'label' then
        local label_text = ''
        if type(option.text) == 'string' then
          label_text = option.text
        elseif type(option.key) == 'function' then
          label_text = option.key()
        end
        self.ui:Label(label_text, x, y, buttons_width, button_heigh)
      elseif option.type == 'slider' then
        local status = self.ui:Slider(option, x, y, buttons_width, button_heigh)
        if option.text ~= '' then
          local temp_text = option.text..': '..around(option.value)
          self.ui:Label(temp_text, x+buttons_width, y, buttons_width, button_heigh)
        end
        if status.changed and option.method then
          option.method(option.value)
        end
      end
      y = y + button_heigh + button_space
    end
  end

  function self.draw()
    self.ui:draw()
  end

  return self
end