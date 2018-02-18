print("\n--Game Started--\n")

--requires
require "helpers"
require "player"
require "menu"
require "position_helpers"
require "game_controller"
require "sprite_controller"
require "bullets_controller"
require "enemies_controller"
require "love_languages"
require "ext/suit"
moan = require "ext/Moan/Moan"

teste = {}
--menus
mainMenu = {}
subMenu = {}
settingsMenu = {}

function love.load()

    --load game
    initialize_settings()

    -- load controllers
    gameController = GameController.new()
    bulletsController = BulletsController.new()
    enemiesController = EnemiesController.new()

    -- load imagens
    load_all_sprites()

    -- load translations
    translations = LoveLanguages.new{path="res/translations", languages={"pt","eng"}}

    -- configure text box manager
    moan.font = love.graphics.newFont("res/fonts/roboto-black.ttf", 16)

    -- prepare menus
    local translationKeys =
    {
        "menu_options_01",
        "menu_options_02",
        "menu_options_03",
        "menu_options_04"
    }
    local translationMethod = translations.translation_of
    local methods =
    {
        function() currentScreen = 3 end,
        function() currentScreen = 1 end,
        function() currentScreen =  5 end,
        --close_game()
    }

    mainMenu = Menu.new{x=WIDTH/2, y=HEIGHT/2, translationKeys=translationKeys, actions=methods, translationMethod=translationMethod, translationKeys=translationKeys}

    translationKeys =
    {
        "game_options_01",
        "game_options_02",
        "game_options_03"
    }
    methods =
    {
        function()
            currentScreen = 4
            gameController.start_game()
        end,
        function()
            currentScreen = 4
            playerTwo = true
            gameController.start_game()
        end,
        function() currentScreen = 2 end
    }

    subMenu = Menu.new{x=WIDTH/2, y=HEIGHT/2, translationKeys=translationKeys, actions=methods, translationMethod=translationMethod, translationKeys=translationKeys}

    translationKeys =
    {
        "settings_options_01",
        "settings_options_02",
        "settings_options_03",
        "settings_options_04"
    }
    methods =
    {
        function() print("som") end, --change song

        function()  print("music") end, --change music
        function() translations.next_translation(); update_all_translations_of_objects() end, --change translations
        function() currentScreen = 2 end --back
    }

    settingsMenu = Menu.new{x=WIDTH/2, y=HEIGHT/2, translationKeys=translationKeys, actions=methods, translationMethod=translationMethod, translationKeys=translationKeys}

    -- test
    enemiesController.create_enemy(100,100)

end

function love.keypressed(key)
  moan.keypressed(key)
end

function love.update(dt)

    if love.keyboard.isDown('escape')   then close_game() end

    if currentScreen == 1 then -- history

    elseif currentScreen == 2 then -- menu
        main_menu_screen()
    elseif currentScreen == 3 then -- sub menu
        select_player_screen()
    elseif currentScreen == 4 then -- game
        gameController.update(dt)
        bulletsController.update(dt)
        enemiesController.update(dt)
    elseif currentScreen == 5 then -- settings menu
        setting_screen()
    end

    moan.update(dt)
end

function love.draw()


    if currentScreen == 1 then -- history

    elseif currentScreen == 2 then -- menu
        mainMenu.draw()
    elseif currentScreen == 3 then -- sub menu
        subMenu.draw()
    elseif currentScreen == 4 then -- game
        gameController.draw()
        bulletsController.draw()
        enemiesController.draw()
    elseif currentScreen == 5 then -- settings menu
        settingsMenu:draw()
    end

    moan.draw()

end
function history_screen()

end
function main_menu_screen()
    mainMenu.update()
end
function select_player_screen()
    subMenu.update()
end
function setting_screen()
    settingsMenu.update()
end

--helpers mover para fora depos
function initialize_settings()
    local settingsTemp = keys_and_values_from_file('configs/settings.txt')
    settings['sound_volum'] = tonumber(settingsTemp['sound_volum'], 10)
    settings['music_volum'] = tonumber(settingsTemp['music_volum'], 10)

    settings['player1'] = {}
    settings['player1']['up']       = settingsTemp['player1_up']
    settings['player1']['down']     = settingsTemp['player1_down']
    settings['player1']['left']     = settingsTemp['player1_left']
    settings['player1']['right']    = settingsTemp['player1_right']
    settings['player1']['shoot']    = settingsTemp['player1_shoot']

    settings['player2'] = {}
    settings['player2']['up']       = settingsTemp['player2_up']
    settings['player2']['down']     = settingsTemp['player2_down']
    settings['player2']['left']     = settingsTemp['player2_left']
    settings['player2']['right']    = settingsTemp['player2_right']
    settings['player2']['shoot']    = settingsTemp['player2_shoot']

end
function update_all_translations_of_objects()
    if mainMenu.update_translations         ~= nil then mainMenu.update_translations() end
    if subMenu.update_translations          ~= nil then subMenu.update_translations() end
    if settingsMenu.update_translations     ~= nil then settingsMenu.update_translations() end
end


