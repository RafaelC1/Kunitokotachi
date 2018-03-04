suit = require "ext/suit"
require "helpers"
require "conf"

Menu = {}

local buttonHeigh = 30
local buttonsWidth = 100
local buttonSpace = 5

function Menu.new(args)
    local self = {
        x = 0,
        y = 0,
        option_strings = {},
        option_methods = {},
        translation_keys = {},
        ui = {},
    }
    self.option_methods = args.actions

    self.x = args.x or 100
    self.y = args.y or 100
    self.ui = suit.new()

    self.translation_keys = args.translation_keys

    function self.update()
        if self.option_strings == nil then return end
        local buttonHeigh = 30
        local buttonsWidth = 100
        local buttonSpace = 5
        local x = self.x - (buttonsWidth/2)
        local y = self.y - ((buttonHeigh*#self.option_strings)/2)
        for i = 1, #self.option_strings do
            if self.ui:Button(self.option_strings[i], x, y + ((buttonHeigh + buttonSpace) * (i-1)),
             buttonsWidth, buttonHeigh).hit then
                if self.option_methods[i] ~= nil then self.option_methods[i]() end
            end
        end
    end
    function self.update_translations()
        for i, translationKey in ipairs(self.translation_keys) do
            self.option_strings[i] = translations[settings.apllicationSettings.language][translationKey]
        end
    end

    function self.draw()
        self.ui:draw()
    end

    self.update_translations()

    return self
end

-- TEST OF NEW MENU FORM

MainMenu = {}

function MainMenu.new()
    local self =
    {
        x = 0,
        y = 0,
        ui = {},
        options =
        {
            {text='', textKey='menu_options_01', action=function() current_screen = 3 end},
            {text='', textKey='menu_options_02', action=function() current_screen = 1 end},
            {text='', textKey='menu_options_03', action=function() current_screen = 5 end},
            {text='', textKey='menu_options_04', action=function() close_game() end}
        }
    }
    self.ui = suit.new()

    function self.update()
        if self.option_strings == nil then return end
        local x = self.x - (buttonsWidth/2)
        local y = self.y - ((buttonHeigh*#self.option_strings)/2)
        for i, button in ipairs(self.options) do
            if self.ui:Button(button.text, x, y + ((buttonHeigh + buttonSpace) * (i-1)), buttonsWidth, buttonHeigh).hit then
                if button.action ~= nil then button.action() end
            end
        end
    end
    function self.update_translations()
        for i, option in ipairs(self.options) do
            self.options.text[i] = translations.translation_of(option.textKey)
        end
    end

    function self.draw()
        self.ui:draw()
    end

    self.update_translations()

    return self
end

SubMenu = {}

function SubMenu.new()
    local self =
    {
        x = 0,
        y = 0,
        ui = {},
        options =
        {
            {text='', textKey='menu_options_01', action=function() current_screen = 3 end},
            {text='', textKey='menu_options_02', action=function() current_screen = 1 end},
            {text='', textKey='menu_options_03', action=function() current_screen = 5 end},
            {text='', textKey='menu_options_04', action=function() close_game() end}
        }
    }
    self.ui = suit.new()

    function self.update()
        if self.option_strings == nil then return end
        local x = self.x - (buttonsWidth/2)
        local y = self.y - ((buttonHeigh*#self.option_strings)/2)
        for i, button in ipairs(self.options) do
            if self.ui:Button(button.text, x, y + ((buttonHeigh + buttonSpace) * (i-1)), buttonsWidth, buttonHeigh).hit then
                if button.action ~= nil then button.action() end
            end
        end
    end
    function self.update_translations()
        for i, option in ipairs(self.options) do
            self.options.text[i] = translations.translation_of(option.textKey)
        end
    end

    function self.draw()
        self.ui:draw()
    end

    self.update_translations()

    return self
end