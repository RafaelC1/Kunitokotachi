-- this file contain all the screets and hacks of the game

time_to_reset_secret = 0.5
current_time_to_reset_secret = 0
-- hack keys
turn_debbuger_on = 'f1'
-- hack passwords
current_secret = ''
power_up_level = 'power'
russian_secret = 'secret'

allow_keys = 'abcdefghijklmnopqrstuvwxyz'

function update_secret(dt)
  current_time_to_reset_secret = current_time_to_reset_secret + dt
  if current_time_to_reset_secret >= time_to_reset_secret then
    reset_secret()
    reset_secret_time()
  end
end

function listen_secrets(key)
  listen_keys(key)
  listen_secret(key)
  check_password()
  reset_secret_time()
end

function listen_keys(key)
  if key == turn_debbuger_on then
    debbuger_mode = not debbuger_mode
    print('debbuger turned on/off')
  end
end

function listen_secret(key)
  local allowed = false
  for i=1, #allow_keys, 1 do
    if key ==  allow_keys:sub(i,i) then
      allowed = true
      break
    end
  end
  if allowed then
    current_secret = current_secret..key
    reset_secret_time()
  else
    reset_secret()
  end
end

function check_password()
  local secret_found = false

  if current_secret == power_up_level then
    secret_found = true
    game_controller.give_free_power_to_players()
  elseif current_secret == russian_secret then
    secret_found = true
    russian_on = true
    sfx_controller.play_sound('russian', true)
  end

  if secret_found then
    reset_secret()
  end
end

function reset_secret_time()
  current_time_to_reset_secret = 0
end

function reset_secret()
  current_secret = ''
end
