json = require "ext/json/json"
  
--files helpers
function close_game()
  love.event.quit()
end

-- this method around values
function around(value)
    return tonumber(string.format("%.0f", value))
end

-- this mehod check if value is in array
function array_include_value(array, value)
  for i, a in ipairs(array) do
    if a == value then
      return true
    end
  end
  return false
end

-- return the current distance of 2 points
function distance(x1, x2, y1, y2)
  return math.sqrt((x1 - x2)^2 + (y1 - y2)^2)
end

function calculate_damage(damage, defense)
  if defense >= 100 then defense = 99 end
  return damage-(damage/100)*defense
end

function file_exist(file_name)
  return love.filesystem.exists(file_name)
end

--read file and give key values back
function json_to_table(j)
  return json.decode(j)
end

function table_to_json(t)
  return json.encode(t)
end

function read_from(file_name)
  return love.filesystem.read(file_name)
end

function write_values_to(file_name, value)
  love.filesystem.write(file_name, value)
end

function translation_of_key(key)
    return translations[settings.apllication_settings.language][key]
end
-- calculate damage
-- check if some object has authorization to touch another
function can_touch(target, projectile)
  if target ~= projectile.owner then
    return true
  else
    return false
  end
end
-- check if 2 objects touch one each other according their bodies
function touch_each_other(object1, object2)
  local minimalDistance = object1.body.radio + object2.body.radio
  local currentDistance = distance(object1.body.x, object2.body.x, object1.body.y, object2.body.y)
  if currentDistance <= minimalDistance then
    return true
  else
    return false
  end
end

function show_dialog(args)
  args.name = args.name or 'message:'
  args.action = args.action or nil
  moan.speak(args.name, args.messages, {x=10, y=10, oncomplete=args.action})
end

-- moviment by screen helpers
function go_to_splash_screen()
  CURRENT_SCREEN = SCREENS.SPLASH_SCREEN
end

function go_to_load_screen()
  CURRENT_SCREEN = SCREENS.LOAD_SCREEN
end

function go_to_history_screen()
  CURRENT_SCREEN = SCREENS.HISTORY_SCREEN
end

function go_to_main_menu_screen()
  CURRENT_SCREEN = SCREENS.MAIN_MENU_SCREEN
end

function go_to_settings_menu_screen()
  CURRENT_SCREEN = SCREENS.SETTINGS_MENU_SCREEN
end

function go_to_pre_game_screen()
  CURRENT_SCREEN = SCREENS.PRE_GAME_MENU_SCREEN
end

function go_to_game_screen()
  CURRENT_SCREEN = SCREENS.GAME_SCREEN
end

function go_to_score_screen()
  CURRENT_SCREEN = SCREENS.SCORE_SCREEN
end

function is_current_screen(screen)
  return CURRENT_SCREEN == screen
end

-- font helpers

function set_game_font_to(new_font_name, size)
  local new_font = fonts.normal
  if new_font_name == 'normal' then
    new_font = fonts.normal[size]
  elseif new_font_name == 'black' then
    new_font = fonts.black[size]
  elseif new_font_name == 'thin' then
    new_font = fonts.thin[size]
  else
    print("font: "..new_font_name.." doesn't exit")
  end
  love.graphics.setFont(new_font)
end


