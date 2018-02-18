Enemy = {}

function Enemy.new(args)
    local self =
    {
        body =
        {
            radio = 1,
            x = 0,
            y = 0
        },
        sprite = {},
        speed = 0,
        hp = 100,
        defense = 30,
        IA = -- this is the positions that enemy shoud perform during it's life circle
        {
            currentPosition = 1, -- the current position of it's life circle
            positions =          -- list of positions
            {
                -- actions mean what enemy does when reach that place:
                -- none = enemy does nothing
                -- shoot = enemy shoot
                -- repeat = enemy back to the first position and do everthing again
                {x=100, y=100, action="none"},
                {x=200, y=100, action="none"},
                {x=300, y=100, action="none"},
                {x=400, y=100, action="repeat"},
            }
        }
    }
    self.body.x = args.x or 10
    self.body.y = args.y or 10
    self.body.radio = args.radio or 50

    self.speed = args.speed or 100
    self.sprite = args.sprite or {}

    -- move enemy acording IA
    function self.move(dt)
        local onX = false
        local onY = false

        if self.IA.currentPosition > #self.IA.positions then
            self.down(dt)
        end

        if self.body.x < (self.IA.positions[self.IA.currentPosition].x-2) then
            self.right(dt)
        elseif self.body.x > (self.IA.positions[self.IA.currentPosition].x+2) then
            self.left(dt)
        else
            onX = true
        end

        if self.body.y < (self.IA.positions[self.IA.currentPosition].y-2) then
            self.down(dt)
        elseif self.body.y > (self.IA.positions[self.IA.currentPosition].y+2) then
            self.up(dt)
        else
            onY = true
        end

        if onX and onY then
            if self.IA.positions[self.IA.currentPosition].action == "shoot" then self.shoot() end
            if self.IA.positions[self.IA.currentPosition].action == "repeat" then
                self.IA.currentPosition = 1
            else
                self.IA.currentPosition = self.IA.currentPosition + 1
            end
        end

    end
    function self.apply_damage(damage)
        self.hp = self.hp - (damage/100)*(100-self.defense)
    end
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
        self.body.x = self.body.x + x
    end
    -- perform vertical move
    function self.vertical_move(y)
        self.body.y = self.body.y + y
    end
    function self.shoot()
        bulletsController.create_bullet{x=self.body.x, y=self.body.y-self.body.radio, xv=0, yv=700, type="playerLevel05"}
    end
    -- die and spawm some gift
    function self.is_alive()
        if self.hp > 0 then
            return true
        else
            return false
        end
    end
    function self.die()
        print("power up spawnado")
    end
    function self.update(dt)
        self.move(dt)
    end
    function self.draw()
        -- self.sprite.draw()
        love.graphics.circle("fill", self.body.x, self.body.y, self.body.radio)
    end

    return self
end