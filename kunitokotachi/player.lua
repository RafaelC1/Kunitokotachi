require "position_helpers"
require "helpers"

Player = {}

function Player.new(args)
    local self =
    {
        player = 1, -- determinate if its player one or two
        keys =      --determinate keys of this players
        {
            up = '',
            down = '',
            left = '',
            right = '',
            shoot = ''
        },
        body =
        {
            radio = 1,
            x = 0,
            y = 0
        },
        shootDelay =
        {
            currentDelay = 0,   -- current time of shoot
            delay = 0.1         -- minimum time that currentDelay should reach before player shoot
        },
        powerLevel =
        {
            "playerLevel01",
            "playerLevel02",
            "playerLevel03",
            "playerLevel04",
            "playerLevel05"
        },
        currentPowerLevel = 1,
        powerPerLevelUp = 100,
        power = 1,
        sprite = {},
        speed = 0,
        hp = 100,
        defense = 30,
        lives = 3,
        selfController = true,      -- variable to block user to move character
        invulnerableTime = 2,       -- max time of ivulnerability
        currentShip = 1,            -- ship of player
        currentSprite = 1,          -- current position of ship (left, right or normal)
        currentBlinkTime = 0,       -- time to blink
        blinkTime = 0.02,           -- time betwen blinks
        blink = false
    }
    self.player = args.player or 1
    self.selfController = true

    self.keys = args.keys

    self.body.x = args.x or 400
    self.body.y = args.y or 900
    self.body.radio = args.radio or 10

    self.lives = args.lives or 3
    self.speed = args.speed or 100
    self.sprite = args.sprites or {}
    -- mover character up
    function self.up(dt)
        local y = -self.speed*dt
        self.vertical_move(y)
    end
    -- move character down
    function self.down(dt)
        local y = self.speed*dt
        self.vertical_move(y)
    end
    -- move character left
    function self.left(dt)
        local x = -self.speed*dt
        self.horizontal_move(x)
    end
    -- move character right
    function self.right(dt)
        local x = self.speed*dt
        self.horizontal_move(x)
    end
    -- perform horizontal move
    function self.horizontal_move(x)
        if inside_screen_width(x+self.body.x) or self.selfController then self.body.x = self.body.x + x end
    end
    -- perform vertical move
    function self.vertical_move(y)
        if inside_screen_height(y+self.body.y) or self.selfController then self.body.y = self.body.y + y end
    end
    -- create a bullet as a shoot
    function self.shoot()
        if self.can_shoot() then
            bulletsController.create_bullet{x=self.body.x, y=self.body.y-self.body.radio, xv=0, yv=-700, type=self.current_ammo()}
            self.shootDelay.currentDelay = self.shootDelay.delay
        end
    end
    -- after player die or respawn all his stats are reseted
    function self.reset()
        self.selfController = true
        self.invulnerableTime = 2
        self.currentPowerLevel = 1
        self.lives = self.lives - 1
        self.power = 1
        self.hp = 100
    end
    -- check if player can shoot
    function self.can_shoot()
        if self.shootDelay.currentDelay > 0 then return false
        else return true end
    end
    -- return the current player ammo, based on it's level
    function self.current_ammo()
        return self.powerLevel[self.currentPowerLevel]
    end
    -- change the player's ammo to a high ammo
    function self.increase_power_level(amountOfLevels)
        self.currentPowerLevel = self.currentPowerLevel + amountOfLevels
        if self.currentPowerLevel > #self.powerLevel then
            self.currentPowerLevel = #self.powerLevel
        end
    end
    -- draim player life
    function self.apply_damage(damage)
        if self.invulnerableTime > 0 then return end
        self.hp = self.hp - (damage/100)*(100-self.defense)
    end
    -- collect power ups and give it to players power cell
    function self.collect_power_up(extraPower)
        self.power = self.power + extraPower
        if self.power >= self.powerPerLevelUp then
            local amount = self.power/self.powerPerLevelUp
            self.increase_power_level(around(amount))
            self.power = 0
        end
    end
    -- return the current player sprite besed on it's current moviment
    function self.current_sprite()
        return self.sprite[self.currentShip][self.currentSprite]
    end
    -- controll keys of character
    function self.control(dt)
        if self.selfController then return end
        if love.keyboard.isDown(self.keys.up) then self.up(dt) end
        if love.keyboard.isDown(self.keys.down) then self.down(dt) end
        if love.keyboard.isDown(self.keys.left) then self.left(dt) end
        if love.keyboard.isDown(self.keys.right) then self.right(dt) end
        if love.keyboard.isDown(self.keys.shoot) then self.shoot() end
    end
    function self.is_alive()
        if self.hp > 0 then
            return true
        else
            return false
        end
    end
    -- perform a death
    function self.die()
        if self.lives <= 0 then
        end
    end
    -- update player logic
    function self.update(dt)
        self.control(dt)
        if self.shootDelay.currentDelay > 0 then
            self.shootDelay.currentDelay = self.shootDelay.currentDelay - 1*dt
        end
        -- blink to show ivulnerability
        if self.invulnerableTime > 0 then
            self.invulnerableTime = self.invulnerableTime -1*dt
            self.currentBlinkTime = self.currentBlinkTime + 1*dt
            if self.currentBlinkTime >= self.blinkTime then
                self.blinkTime = self.blinkTime + 0.005
                self.currentBlinkTime = 0
                self.blink = not self.blink
            end
        else
            self.blink = false
        end
    end
    -- draw player
    function self.draw()
        if self.blink then return end
        love.graphics.draw(self.current_sprite(), self.body.x-self.body.radio, self.body.y-self.body.radio)
    end
    -- reset player position
    function self.reset_position_to(x, y)
        local newX = x or 100
        local newY = y or 100
        self.body.x = newY
        self.body.x = newX
    end

    return self
end