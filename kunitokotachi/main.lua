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
require "ext/suit"
moan = require "ext/Moan/Moan"

--menus
local main_menu = {}
local sub_menu = {}
local settings_menu = {}

function love.load()
  --load game
  initialize_settings()

  -- load controllers
  game_controller = GameController.new()
  bullets_controller = BulletsController.new()
  enemies_controller = EnemiesController.new()
  power_ups_controller = PowerUpsController.new()

  -- load imagens
  load_all_sprites()

  -- load gonts
  load_all_fonts()

  -- load translations
  translations['pt'] = read_values_from('res/translations/all_pt.json')
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
    function() current_screen = 3 end,
    function() current_screen = 1 end,
    function() current_screen =  5 end,
    --close_game()
  }

  main_menu = Menu.new{x=WIDTH/2, y=HEIGHT/2, translation_keys=translation_keys, actions=methods, translation_keys=translation_keys}

  translation_keys =
  {
    "game_options_01",
    "game_options_02",
    "game_options_03"
  }
  methods =
  {
    function() -- single player
      current_screen = 4
      game_controller.start_game(1)
    end,
    function() -- multiplayer co-op
      current_screen = 4
      game_controller.start_game(2)
    end,
    function() current_screen = 2 end
  }

  sub_menu = Menu.new{x=WIDTH/2, y=HEIGHT/2, translation_keys=translation_keys, actions=methods, translation_keys=translation_keys}

  translation_keys =
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
    function() current_screen = 2 end --back
  }

  settings_menu = Menu.new{x=WIDTH/2, y=HEIGHT/2, translation_keys=translation_keys, actions=methods}

  -- test
  enemies_controller.create_enemy(100,100)

end

function love.keypressed(key)
moan.keypressed(key)
end

function love.update(dt)

  if love.keyboard.isDown('escape')   then close_game() end

  if current_screen == 1 then -- history

  elseif current_screen == 2 then -- menu
    main_menu_screen()
  elseif current_screen == 3 then -- sub menu
    select_player_screen()
  elseif current_screen == 4 then -- game
    game_controller.update(dt)
  elseif current_screen == 5 then -- settings menu
    setting_screen()
  end

  moan.update(dt)
end

function love.draw()
  if current_screen == 1 then -- history
  elseif current_screen == 2 then -- menu
    main_menu.draw()
  elseif current_screen == 3 then -- sub menu
    sub_menu.draw()
  elseif current_screen == 4 then -- game
    game_controller.draw()
  elseif current_screen == 5 then -- settings menu
    settings_menu:draw()
  end

  moan.draw()

end
function history_screen()

end
function main_menu_screen()
  main_menu.update()
end
function select_player_screen()
  sub_menu.update()
end
function setting_screen()
  settings_menu.update()
end

--helpers mover para fora depos
function initialize_settings()
  local settingsTemp 
  settings['apllicationSettings'] = read_values_from('configs/applicationSettings.json')
  settings['playersSettings'] = read_values_from('configs/controllersSettings.json')

  -- settingsTemp = read_values_from('configs/controllersSettings.json')


end
function update_all_translations_of_objects()
  if main_menu.update_translations         ~= nil then main_menu.update_translations() end
  if sub_menu.update_translations          ~= nil then sub_menu.update_translations() end
  if settings_menu.update_translations     ~= nil then settings_menu.update_translations() end
end


