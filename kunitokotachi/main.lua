print("\n--Game Started--\n")

--requires
require "helpers"
require "player"
require "menu"
require "position_helpers"
require "game_controller"
require "assets_loader"
require "bullets_controller"
require "enemies_controller"
require "power_ups_controller"
require "explosions_controller"
require "secrets"
require "settings_menu"
require "splash_screen"
require "history_screen"
require "settings"
require "ext/suit"
require "select_ship_menu"
moan = require "ext/Moan/Moan"

--menus
local main_menu = {}
local sub_menu = {}
local settings_menu = {}

-- screens
local splash_screen = {}
local history_screen = {}

function love.load()

  load_all_images()
  define_sprites()

-- define game icon on top window
  love.window.setIcon(risoto_tomate_icon)

  --load settings
  settings = Settings.new()

  -- load list of translations
  translations.pt = json_to_table(read_from('res/translations/all_pt.json'))
  translations.eng = json_to_table(read_from('res/translations/all_eng.json'))
  translations.esp = json_to_table(read_from('res/translations/all_esp.json'))

  -- load controllers
  game_controller = GameController.new()
  bullets_controller = BulletsController.new()
  enemies_controller = EnemiesController.new()
  power_ups_controller = PowerUpsController.new()
  explosions_controller = ExplosionsController.new()

  -- load gonts
  load_all_fonts()

  -- configure text box manager
  moan.font = love.graphics.newFont("res/fonts/roboto-black.ttf", 16)

  -- load screens
  splash_screen = SplashScreen.new()
  history_screen = HistoryScreen.new()

  -- creating main menu
  local methods =
  {
    function()
      go_to_pre_game_screen()
      sub_menu.reset_players()
     end,
    function() go_to_history_screen() end,
    function() go_to_settings_menu_screen() end,
    function()
      if game_started then
        love.event.quit()
      end
    end
  }
  main_menu = Menu.new{ x=WIDTH/2, y=HEIGHT/2 }
  main_menu.add_label('menu_options_05')
  main_menu.add_button('menu_options_01', methods[1])
  main_menu.add_button('menu_options_02', methods[2])
  main_menu.add_button('menu_options_03', methods[3])
  main_menu.add_button('menu_options_04', methods[4])

-- creating sub_menu or pre game menu
  sub_menu = SelectShipMenu.new{ x=WIDTH/2, y=HEIGHT/2 }
  methods =
  {
    function() go_to_main_menu_screen() end
  }
  -- sub_menu.add_button('game_options_02', methods[2])
  sub_menu.add_button('game_options_03', methods[1])

  -- creating settings menu
  settings_menu = SettingsMenu.new{ x=WIDTH/2, y=HEIGHT/2 }
  methods =
  {
    function()
      settings.next_language(1)
      main_menu.update_all()
      sub_menu.update_all()
      settings_menu.update_all()
    end, --change translations
    function()
      go_to_main_menu_screen()
      settings.save_all_settings()
    end, --back
    settings.set_song_volum,
    settings.set_music_volum,
    settings_menu.edit_player_controllers
  }
  settings_menu.add_label('settings_options_05')
  settings_menu.add_button('settings_options_03', methods[1])
  settings_menu.add_slider(0, 100, settings.apllication_settings.song_volum, 10, {key='settings_options_01', change_method=methods[3]})
  settings_menu.add_slider(0, 100, settings.apllication_settings.music_volum, 10, {key='settings_options_02', change_method=methods[4]})
  settings_menu.add_button('settings_options_06', methods[5])
  settings_menu.add_button('settings_options_04', methods[2])

  game_started = true
end

function love.keypressed(key)
  if is_current_screen(SCREENS.SPLASH_SCREEN) then
    if key == settings.players_settings.player_01_keys.shoot then
      moan.clearMessages()
      splash_screen.end_time()
    end
  elseif is_current_screen(SCREENS.LOAD_SCREEN) then

  elseif is_current_screen(SCREENS.HISTORY_SCREEN) then
    history_screen.key_events(key)
  elseif is_current_screen(SCREENS.MAIN_MENU_SCREEN) then

  elseif is_current_screen(SCREENS.PRE_GAME_MENU_SCREEN) then
    sub_menu.key_events(key)
  elseif is_current_screen(SCREENS.GAME_SCREEN) then
    game_controller.key_events(key)
  elseif is_current_screen(SCREENS.SETTINGS_MENU_SCREEN) then
    settings_menu.key_events(key)
  end

  if key == settings.players_settings.global_keys.back and debbuger_mode then
    close_game()
  end

  listen_secrets(key)

  moan.keypressed(key)
end

function love.update(dt)

  if is_current_screen(SCREENS.SPLASH_SCREEN) then
    splash_screen.update(dt)
  elseif is_current_screen(SCREENS.LOAD_SCREEN) then

  elseif is_current_screen(SCREENS.HISTORY_SCREEN) then
    history_screen.update(dt)
  elseif is_current_screen(SCREENS.MAIN_MENU_SCREEN) then
    main_menu.update()
  elseif is_current_screen(SCREENS.PRE_GAME_MENU_SCREEN) then
    sub_menu.update(dt)
  elseif is_current_screen(SCREENS.GAME_SCREEN) then
    game_controller.update(dt)
  elseif is_current_screen(SCREENS.SETTINGS_MENU_SCREEN) then
    settings_menu.update()
  end

  update_secret(dt)

  moan.update(dt)
end

function love.draw()
  if is_current_screen(SCREENS.SPLASH_SCREEN) then
    splash_screen.draw()
  elseif is_current_screen(SCREENS.LOAD_SCREEN) then

  elseif is_current_screen(SCREENS.HISTORY_SCREEN) then
    history_screen.draw()
  elseif is_current_screen(SCREENS.MAIN_MENU_SCREEN) then
    level_background_sprites.level_01_sprites[4].draw{x=WIDTH/2, y=HEIGHT/2, scala_x=1, scala_y=1, rot=0}
    main_menu.draw()
  elseif is_current_screen(SCREENS.PRE_GAME_MENU_SCREEN) then
    level_background_sprites.level_01_sprites[4].draw{x=WIDTH/2, y=HEIGHT/2, scala_x=1, scala_y=1, rot=0}
    sub_menu.draw()
  elseif is_current_screen(SCREENS.GAME_SCREEN) then
    game_controller.draw()
  elseif is_current_screen(SCREENS.SETTINGS_MENU_SCREEN) then
    level_background_sprites.level_01_sprites[4].draw{x=WIDTH/2, y=HEIGHT/2, scala_x=1, scala_y=1, rot=0}
    settings_menu.draw()
  end
  moan.draw()
end
