  json = require "ext/json/json"
--files helpers
function close_game()
  love.event.quit()
end
function around(value)
    return tonumber(string.format("%.0f", value))
end
function file_exist(filePath)
    local exist = love.filesystem.exists(filePath)
    return exist
end
--read file and give key values back
function read_values_from(path)
  local codedText = ""
  for line in love.filesystem.lines(path) do
    codedText = codedText..line
  end
  local decodedText = json.decode(codedText)
  return decodedText
end
-- calculate damage
function calculate_damage(damage, defense)
  if defense >= 100 then defense = 99 end
  return damage-(damage/100)*defense
end
-- return the current distance of 2 points
function distance(x1, x2, y1, y2)
  return math.sqrt((x1 - x2)^2 + (y1 - y2)^2)
end
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

