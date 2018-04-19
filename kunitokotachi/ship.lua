require "object"
require "position_helpers"
require "helpers"
require "assets_loader"

Ship = {}

function Ship.new(args)
  local self = Object.new(args)


  self.r = 0
  self.g = 0
  self.b = 255

  self.owner = args.owner or self
  self.self_controller = args.self_controller or true      -- variable to block user to move character

  self.invulnerable_time = 2       -- max time of ivulnerability

  self.current_power_level = 1      -- current level of power according collected power ups
  self.power = 1

  self.shoot_delay =
  {
    current_delay = 0,   -- current time of shoot
    delay = 0.05         -- minimum time that current_delay should reach before ship shoot
  }

  self.keys = args.keys

  self.power = 1
  self.power_level = {}            -- level of power ups collected
  self.power_per_level_up = 100      -- for each time of power_level reach this amount of power, rise current_power_level by one
  self.current_power_level = 1
  
  self.current_blink_time = 0       -- time to blink
  self.default_blink_time = 0.02
  self.blink_time = self.default_blink_time or 0.02
  self.blink = false

  self.current_ship = 1            -- ship of ship
  self.current_ship_sprite = 1          -- current position of ship (left, right or normal)

  self.self_controller = true

  -- perform horizontal move
  function self.horizontal_move(x)
    if inside_screen_width(x+self.body.x) or self.self_controller then
      self.body.x = self.body.x + x
    end
  end
  -- perform vertical move
  function self.vertical_move(y)
    if inside_screen_height(y+self.body.y) or self.self_controller then
      self.body.y = self.body.y + y
    end
  end
  -- return the current ship ammo, based on it's level
  function self.current_ammo()
    return self.owner.level_settings[string.format("level_%02d", self.current_power_level)]
  end
  -- check if ship can shoot
  function self.can_shoot()
    if self.shoot_delay.current_delay > 0 then return false
    else return true end
  end
  -- create a bullet as a shoot
  function self.shoot()
    if self.can_shoot() then
      bullets_controller.create_bullet(self.body.x, self.body.y-self.body.radio/3, 0, -1, 'player', self.current_ammo().bullet, self.owner)
      self.shoot_delay.current_delay = self.current_ammo().delay
    end
  end
  -- collect power ups and give it to ships power cell
  function self.collect_power_up(collected_power)
    if not self.owner.level_exist(self.current_power_level+1) then return end
    self.power = self.power + collected_power
    if self.power >= self.power_per_level_up then
      local amount_of_extra_levels = self.power/self.power_per_level_up
      self.increase_power_level(around(amount_of_extra_levels))
      self.power = 0
    end
  end
  -- change the ship's ammo to a high ammo
  function self.increase_power_level(amount_of_levels)
    self.current_power_level = self.current_power_level + amount_of_levels
    -- if there is no more leves to gain, reduce by one to avoid problems with null level
    if not self.owner.level_exist(self.current_power_level) then
      self.current_power_level = self.current_power_level - 1
    end
  end
  -- return the current ship sprite besed on it's current moviment
  function self.current_sprite()
    return self.sprite[self.current_ship][self.current_ship_sprite]
  end
  -- update ship logic
  function self.update(dt)
    local current_x = 0
    local current_y = 0

    if not self.self_controller then
      if love.keyboard.isDown(self.keys.up) then
        current_y = -self.speed*dt
      end
      if love.keyboard.isDown(self.keys.down) then
        current_y = self.speed*dt
      end
      if love.keyboard.isDown(self.keys.left) then
        current_x = -self.speed*dt
      end
      if love.keyboard.isDown(self.keys.right) then
        current_x = self.speed*dt
      end
      if love.keyboard.isDown(self.keys.shoot) then
        self.shoot()
      else
        -- if current ammo is the laser, when player press up shoot button, laser shoud stop to work on the same time
        if #bullets_controller.bullets.player > 0 then
          if bullets_controller.bullets_settings.player[self.current_ammo().bullet].follow_owner then
            bullets_controller.destroy_all_bullets_by_owner(bullets_controller.bullets.player, self.owner)
          end
        end
      end
      -- hack
      if love.keyboard.isDown(string.format('1')) then
        self.collect_power_up(10)
      end
    end 

    self.horizontal_move(current_x)
    self.vertical_move(current_y)

    if self.shoot_delay.current_delay > 0 then
      self.shoot_delay.current_delay = self.shoot_delay.current_delay - 1*dt
    end
    -- blink to show ivulnerability
     if self.invulnerable_time > 0 then
        self.invulnerable_time = self.invulnerable_time -1*dt
        self.current_blink_time = self.current_blink_time + 1*dt
        self.invulnerable = true
      if self.current_blink_time >= self.blink_time then
        self.blink_time = self.blink_time + 0.005
        self.current_blink_time = 0
        self.blink = not self.blink
      end
    else
      self.blink = false
      self.invulnerable = false
    end
  end
  -- draw ship
  function self.draw()
    self.draw_test()
    if self.blink then return end
    local width = self.current_sprite():getWidth()/2
    local height = self.current_sprite():getHeight()/2
    love.graphics.draw(self.current_sprite(), self.body.x-width, self.body.y-height)
  end

  return self
end