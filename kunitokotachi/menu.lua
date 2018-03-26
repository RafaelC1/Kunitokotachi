suit = require "ext/suit"
require "helpers"
require "conf"

Menu = {}

local buttonHeigh = 30
local buttonsWidth = 100
local buttonSpace = 5

function Menu.new(args)
  local self = {}

  self.x = args.x or 100
  self.y = args.y or 100

  self.ui = suit.new()

  self.options = {}

  function self.add_button(key, method)
    button = { type='button', text='', key=key, method=method }
    self.update_text(button)
    table.insert(self.options, button)
  end
  function self.add_label(key)
    label = { type='label', text='', key=key }
    self.update_text(label)
    table.insert(self.options, label)
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
  function self.update()
    local button_heigh = 30
    local buttons_width = 100
    local buttonSpace = 5
    local x = self.x - (buttonsWidth/2)
    local y = self.y - ((buttonHeigh*#self.options)/2)
    for i, option in ipairs(self.options) do
      if option.type == 'button' then
        if self.ui:Button(option.text, x, y, buttons_width, button_heigh).hit then
          if option.method ~= nil then option.method() end
        end
      elseif option.type == 'label' then
        self.ui:Label(option.text, x, y, buttons_width, button_heigh)
      elseif option.type == 'slider' then
        local status = self.ui:Slider(option, x, y, buttons_width, button_heigh)
        if option.text ~= '' then
          local temp_text = option.text..': '..option.value
          self.ui:Label(temp_text, x+buttons_width, y, buttons_width, button_heigh)
        end
        if status.changed and option.method then
          option.method(option.value)
        end
      end
      y = y + buttonHeigh + buttonSpace
    end
  end
  function self.draw()
    self.ui:draw()
  end

  return self
end