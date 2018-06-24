require "assets_loader"
require "body"
require "class"
require "health"
require "helpers"
require "position_helpers"
require "weapons_manager"

Ship = {}

function Ship.new(args)
  local self = Class.new()

  self.inherit(Body.new(args))
  self.inherit(Health.new(args))
  self.inherit(WeaponsManager.new())

  self.title = 'player'

  self.owner = args.owner or self
  self.self_controller = args.self_controller or true      -- variable to block user to move character

  self.current_power_level = 1      -- current level of power according collected power ups
  self.power = 1

  self.keys = args.keys

  self.power = 1
  self.power_level = {}            -- level of power ups collected
  self.power_per_level_up = 100      -- for each time of power_level reach this amount of power, rise current_power_level by one
  self.current_power_level = 1
  
  self.current_blink_time = 0       -- time to blink
  self.default_blink_time = 0.02
  self.blink_time = self.default_blink_time or 0.02
  self.blink = false

  self.current_ship = args.ship_model_name or 'ship_01'            -- ship of ship
  self.current_ship_position = 'center'          -- current position of ship (left, right or normal)
  self.time_turning = 0.08
  self.current_time_turning = 0

  self.sprites = args.sprites or nil

  self.self_controller = true

  function self.max_time_to_extra_turn()
    return self.current_time_turning >= self.time_turning
  end

  -- this metho count the time that player is turning the ship to change the sprite
  function self.count_time_turning_to_change_sprite(dt)
    if not self.max_time_to_extra_turn() then
      self.current_time_turning = self.current_time_turning + dt
    end
  end
  -- set the correct sprite of position
  function self.correct_position_sprite(side)
    local position = 'center'
    if side < 0 then
        position = 'left'
      if self.max_time_to_extra_turn() then
        position = 'extra_left'
      end
    elseif side > 0 then
        position = 'right'
      if self.max_time_to_extra_turn() then
        position = 'extra_right'
      end
    end
    self.current_ship_position = position
  end

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
  -- collect power ups and give it to ships power cell
  function self.collect_power_up(collected_power)
    if not self.owner.level_exist(self.current_power_level+1) then
      -- if player get the last level, all power collected turn in score
      self.owner.earn_points(collected_power*1000)
      return
    end
    self.power = self.power + collected_power
    if self.power >= self.power_per_level_up then
      local amount_of_extra_levels = self.power/self.power_per_level_up
      self.increase_power_level(around(amount_of_extra_levels))
      self.power = 0
      -- update all weapons with the new ammo
      self.change_ammo_of_all_weapons(self.current_ammo().bullet_name)
      self.change_delay_of_all_weapons(self.current_ammo().delay)
    end
  end
  -- change the ship's ammo to a high ammo
  function self.increase_power_level(amount_of_levels)
    self.show_charger_animation()
    self.current_power_level = self.current_power_level + amount_of_levels
    -- if there is no more leves to gain, reduce by one to avoid problems with null level
    if not self.owner.level_exist(self.current_power_level) then
      self.current_power_level = self.current_power_level - 1
    end
  end
  -- show the charger animation
  function self.show_charger_animation()
    explosions_controller.create_charger_explosion(self.body.x, self.body.y)
  end
  -- return the current ship sprite besed on it's current moviment
  function self.current_sprite()
    return self.sprites[self.current_ship][self.current_ship_position]
  end
  -- update ship logic
  function self.update(dt)
    local current_x = 0
    local current_y = 0
    local horizontal_keys_pressend = false

    self.correct_position_sprite(0)

-- controller of the keys of ship
    if not self.self_controller then
      if love.keyboard.isDown(self.keys.up) then
        current_y = -self.speed*dt
      end
      if love.keyboard.isDown(self.keys.down) then
        current_y = self.speed*dt
      end
      if love.keyboard.isDown(self.keys.left) then
        self.correct_position_sprite(-1)
        horizontal_keys_pressend = true
        current_x = -self.speed*dt
      end
      if love.keyboard.isDown(self.keys.right) then
        self.correct_position_sprite(1)
        horizontal_keys_pressend = true
        current_x = self.speed*dt
      end
      if love.keyboard.isDown(self.keys.shoot) then
        self:shoot_every_weapon()
      else
        -- if current ammo is the laser, when player press up shoot button, laser shoud stop to work on the same time
        if #bullets_controller.bullets.player > 0 then
          if bullets_controller.bullets_settings[self.current_ammo().bullet_name].follow_owner then
            bullets_controller.destroy_all_bullets_by_owner(bullets_controller.bullets.player, self.owner)
          end
        end
      end
    end

    if horizontal_keys_pressend then
      self.count_time_turning_to_change_sprite(dt)
    else
      self.current_time_turning = 0
    end

    self.horizontal_move(current_x)
    self.vertical_move(current_y)

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

    -- update weapons status
    for _, weapon in ipairs(self.weapons) do
      weapon.update(dt)
    end
  end
  -- draw ship
  function self.draw()
    -- self.draw_test()
    if self.blink then
    else
      self.current_sprite().draw{x=self.body.x,
                                 y=self.body.y,
                                 scala_x=1,
                                 scala_y=1,
                                 rot=0}
    end
  end

  self.add_weapon{ammo_name=self.current_ammo().bullet_name,
                  delay=self.current_ammo().delay,
                  relative_x=0,
                  relative_y=-30,
                  direction_x=0,
                  direction_y=-1}

  self.change_ammo_of_all_weapons(self.current_ammo().bullet_name)
  self.change_delay_of_all_weapons(self.current_ammo().delay)

  self.invulnerable_time = 2
  self.invulnerable = true

  return self
end