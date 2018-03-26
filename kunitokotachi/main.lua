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
require "settings"
require "ext/suit"
moan = require "ext/Moan/Moan"

--menus
local main_menu = {}
local sub_menu = {}
local settings_menu = {}
local teste = {}

function love.load()

  --load game
  settings = Settings.new()

  -- load imagens
  load_all_sprites()

  -- load controllers
  game_controller = GameController.new()
  bullets_controller = BulletsController.new()
  enemies_controller = EnemiesController.new()
  power_ups_controller = PowerUpsController.new()

  -- load gonts
  load_all_fonts()

  -- load translations
  translations['pt'] = json_to_table(read_from('res/translations/all_pt.json'))
  translations['eng'] = json_to_table(read_from('res/translations/all_eng.json'))
  translations['esp'] = json_to_table(read_from('res/translations/all_esp.json'))
  -- translations['eng'] =read_values_from('res/translations/all_eng.json')

  -- configure text box manager
  moan.font = love.graphics.newFont("res/fonts/roboto-black.ttf", 16)

  -- prepare menus
  local translation_keys =
  {
    "menu_options_01",
    "menu_options_02",
    "menu_options_03",
    "menu_options_04"
  }
  local methods =
  {
    function() CURRENT_SCREEN = SCREENS.PRE_GAME_MENU_SCREEN  end,
    function() CURRENT_SCREEN = SCREENS.HISTORY_SCREEN  end,
    function() CURRENT_SCREEN = SCREENS.SETTINGS_MENU_SCREEN  end,
    --close_game()
  }
  main_menu = Menu.new{ x=WIDTH/2, y=HEIGHT/2 }
  main_menu.add_label('menu_options_05')
  for i=1, #translation_keys do
    main_menu.add_button(translation_keys[i], methods[i])
  -- main_menu.add_label(translation_keys[1])
  end

  translation_keys =
  {
    "game_options_01",
    "game_options_02",
    "game_options_03"
  }
  methods =
  {
    function() -- single player
      CURRENT_SCREEN = SCREENS.GAME_SCREEN
      game_controller.start_game(1)
    end,
    function() -- multiplayer co-op
      CURRENT_SCREEN = SCREENS.GAME_SCREEN
      game_controller.start_game(2)
    end,
    function() CURRENT_SCREEN = SCREENS.MAIN_MENU_SCREEN end
  }
  sub_menu = Menu.new{ x=WIDTH/2, y=HEIGHT/2 }
  sub_menu.add_label('game_options_04')
  for i=1, #translation_keys do
    sub_menu.add_button(translation_keys[i], methods[i])
  end

  methods =
  {
    function() settings.next_language(1); update_all_translations_of_objects() end, --change translations
    function() current_screen = 2; write_values_to('applicationSettings.json', table_to_json(settings.apllication_settings)) end, --back
    settings.set_song_volum,
    settings.set_music_volum
  }
  settings_menu = Menu.new{ x=WIDTH/2, y=HEIGHT/2 }
  settings_menu.add_label('settings_options_05')
  settings_menu.add_button('settings_options_03', methods[1])
  settings_menu.add_slider(0, 100, settings.apllication_settings.song_volum, 10, {key='settings_options_01', change_method=methods[3]})
  settings_menu.add_slider(0, 100, settings.apllication_settings.music_volum, 10, {key='settings_options_02', change_method=methods[4]})
  settings_menu.add_button('settings_options_04', methods[2])
end

function love.keypressed(key)
moan.keypressed(key)
end

function love.update(dt)
  if love.keyboard.isDown('escape')   then close_game() end

  if CURRENT_SCREEN == SCREENS.SPLASH_SCREEN then

  elseif CURRENT_SCREEN == SCREENS.LOAD_SCREEN then

  elseif CURRENT_SCREEN == SCREENS.HISTORY_SCREEN then

  elseif CURRENT_SCREEN == SCREENS.MAIN_MENU_SCREEN then
    main_menu.update()
  elseif CURRENT_SCREEN == SCREENS.PRE_GAME_MENU_SCREEN then
    sub_menu.update()
  elseif CURRENT_SCREEN == SCREENS.GAME_SCREEN then
    game_controller.update(dt)
  elseif CURRENT_SCREEN == SCREENS.SETTINGS_MENU_SCREEN then
    settings_menu.update()
  end

  moan.update(dt)
end

function love.draw()
  if CURRENT_SCREEN == SCREENS.SPLASH_SCREEN then

  elseif CURRENT_SCREEN == SCREENS.LOAD_SCREEN then

  elseif CURRENT_SCREEN == SCREENS.HISTORY_SCREEN then

  elseif CURRENT_SCREEN == SCREENS.MAIN_MENU_SCREEN then
    main_menu.draw()
  elseif CURRENT_SCREEN == SCREENS.PRE_GAME_MENU_SCREEN then
    sub_menu.draw()
  elseif CURRENT_SCREEN == SCREENS.GAME_SCREEN then
    game_controller.draw()
  elseif CURRENT_SCREEN == SCREENS.SETTINGS_MENU_SCREEN then
    settings_menu.draw()
  end

  moan.draw()

end

--helpers mover para fora depos

function update_all_translations_of_objects()
  if main_menu.update_all         ~= nil then main_menu.update_all() end
  if sub_menu.update_all          ~= nil then sub_menu.update_all() end
  if settings_menu.update_all     ~= nil then settings_menu.update_all() end
end


