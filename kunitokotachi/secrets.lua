-- this file contain all the screets and hacks of the game

time_to_reset_secret = 2
current_time_to_reset_secret = 0
-- hack keys
turn_debbuger_on = 'f1'
-- hack passwords
current_secret = ''
power_one_level = 'asd'

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
  current_secret = current_secret..key
end

function check_password()
  local secret_found = false

  if current_secret == power_one_level then
    secret_found = true
    print('extra power secret')
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
