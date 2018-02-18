require "love_languages"
suit = require "ext/suit"
require "helpers"

Menu = {}

local buttonHeigh = 30
local buttonsWidth = 100
local buttonSpace = 5

function Menu.new(args)
    local self = {
        x = 0,
        y = 0,
        optionStrings = {},
        optionMethods = {},
        translationMethod = {},
        translationKeys = {},
        ui = {},
    }
    self.optionMethods = args.actions

    self.x = args.x or 100
    self.y = args.y or 100
    self.ui = suit.new()

    self.translationMethod = args.translationMethod
    self.translationKeys = args.translationKeys

    function self.update()
        if self.optionStrings == nil then return end
        local buttonHeigh = 30
        local buttonsWidth = 100
        local buttonSpace = 5
        local x = self.x - (buttonsWidth/2)
        local y = self.y - ((buttonHeigh*#self.optionStrings)/2)
        for i = 1, #self.optionStrings do
            if self.ui:Button(self.optionStrings[i], x, y + ((buttonHeigh + buttonSpace) * (i-1)),
             buttonsWidth, buttonHeigh).hit then
                if self.optionMethods[i] ~= nil then self.optionMethods[i]() end
            end
        end
    end
    function self.update_translations()
        for i, translation in ipairs(self.translationKeys) do
            self.optionStrings[i] = self.translationMethod(self.translationKeys[i])
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
            {text='', textKey='menu_options_01', action=function() currentScreen = 3 end},
            {text='', textKey='menu_options_02', action=function() currentScreen = 1 end},
            {text='', textKey='menu_options_03', action=function() currentScreen = 5 end},
            {text='', textKey='menu_options_04', action=function() close_game() end}
        }
    }
    self.ui = suit.new()

    function self.update()
        if self.optionStrings == nil then return end
        local x = self.x - (buttonsWidth/2)
        local y = self.y - ((buttonHeigh*#self.optionStrings)/2)
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
            {text='', textKey='menu_options_01', action=function() currentScreen = 3 end},
            {text='', textKey='menu_options_02', action=function() currentScreen = 1 end},
            {text='', textKey='menu_options_03', action=function() currentScreen = 5 end},
            {text='', textKey='menu_options_04', action=function() close_game() end}
        }
    }
    self.ui = suit.new()

    function self.update()
        if self.optionStrings == nil then return end
        local x = self.x - (buttonsWidth/2)
        local y = self.y - ((buttonHeigh*#self.optionStrings)/2)
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