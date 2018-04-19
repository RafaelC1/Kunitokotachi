SplashScreen = {}

function SplashScreen.new()
  local self = {}
  self.loaded = false
  self.logo = {}
  self.logo.image = love.graphics.newImage('res/assets/game_logo.png')
  self.logo.x = 0
  self.logo.y = 0

  self.time = {}
  self.time.max_time = 3     -- in secounds
  self.time.current_time = 0 -- in secounds

  function self.end_time()
    if self.loaded then
      self.time.current_time = self.time.max_time + 1
    end
  end

  function self.update_time(dt)
    self.time.current_time = self.time.current_time + dt
  end

  function self.calculate_position()
    local temp_x, temp_y = self.logo.image:getDimensions()
    self.logo.x = WIDTH/2 - temp_x/2
    self.logo.y = HEIGHT/2 - temp_y/2
  end
  function self.update(dt)
    self.update_time(dt)
    if self.time.current_time > self.time.max_time then
      CURRENT_SCREEN = SCREENS.HISTORY_SCREEN
    end
  end
  function self.draw()
    love.graphics.draw(self.logo.image, self.logo.x, self.logo.y)
  end

  self.calculate_position()
  self.loaded = load_all_sprites()

  return self
end