require "helpers"
require "bullet"
require "sprite_controller"

BulletsController = {}

function BulletsController.new()
    local self =
    {
        bullets =
        {
            ['player'] = {},
            ['enemy'] = {}
        }
    }
    -- spawm a bullet
    function self.create_bullet(args)
        args.x = args.x or 100
        args.y = args.y or 100
        args.xv = args.xv or 0
        args.yv = args.yv or 100
        args.type = args.type or "playerLevel01"
        local sprite = self.sprite_of_bullet_type(args.type)
        local bullet = Bullet.new{sprite=sprite, x=args.x, y=args.y, xv=args.xv, yv=args.yv}
        table.insert(self.bullets.player, bullet)
    end
    -- return the correct sprite of some bullet to spawn it
    function self.sprite_of_bullet_type(bulletType)
        return bulletSprites[bulletType]
    end
    -- check each bullet it it is out of screen so delete it
    function self.check_bullets_position(bullets)
        for i, bullet in ipairs(bullets) do
            if not inside_screen_width(bullet.body.x) or
                not inside_screen_width(bullet.body.y) then
                self.destroy_bullet(i)
            end
        end
    end
    -- destroy a bullet by id
    function self.destroy_bullet(bulletID)
        table.remove(self.bullets.player, bulletID)
    end
    -- destroy all bullets on list
    function self.destroy_all_bullets()
        self.bullets.player = {}
        self.bullets.enemy = {}
    end
    function self.update(dt)
        if #self.bullets.player == 0 then return end
        for i, bullet in ipairs(self.bullets.player) do
            bullet.update(dt)
        end
        self.check_bullets_position(self.bullets.player)
        self.check_bullets_position(self.bullets.enemy)
    end
    function self.draw()
        if #self.bullets.player == 0 then return end
        for i, bullet in ipairs(self.bullets.player) do
            bullet.draw()
        end
    end
    return self
end