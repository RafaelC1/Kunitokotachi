Bullet = {}

function Bullet.new(args)
    local self = {
        body =
        {
            radio = 1,
            x = 0,
            y = 0
        },
        xv = 0,
        yv = 0,
        sprite = {},
        speed = {},
        damage = {},
        radio = {},
        sprite,
        radio = 1
    }
    self.body.x = args.x or 10
    self.body.y = args.y or 10
    self.body.radio = args.radio or 10
    self.xv = args.xv or 10
    self.yv = args.yv or 10
    self.sprite = args.sprite
    self.speed = args.speed or 100
    self.damage = args.damage or 20
    self.radio = args.radio or 10

    function self.update(dt)
        self.body.x = self.body.x + self.xv*dt
        self.body.y = self.body.y + self.yv*dt
        self.sprite.update(dt)
    end
    function self.draw()
        self.sprite.draw{x=self.body.x, y=self.body.y, scala=1}
    end

    return self
end