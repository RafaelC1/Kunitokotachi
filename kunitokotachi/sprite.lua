Sprite = {}

-- this sprite just work if all animation sprites are on the same line

function Sprite.new(image, x, y, w, h, size, fps)
    local self =
    {
        size = 0, -- size os sprite it is the width and the height
        image = {}, -- source image
        currentFrame = 1, -- current frame of animation
        timer = 0,
        fps = 1,
        xOffSet = 0,
        quad = {},
        quadAccount = 1, -- acount of colunms of this animation
        x = 1, -- start position of sprite y
        y = 1, -- start position of sprite y
        w = 1, -- from the start x position get the width of sprite
        h = 1, -- from the start y position get the height of sprite
    }

    self.image = image
    self.size = size
    self.fps = 1/fps
    self.x = x
    self.y = y
    self.w = w
    self.h = h
    self.quadAccount = self.w / self.size

    self.quad = love.graphics.newQuad(self.x, self.y, self.size, self.size, self.image:getDimensions())

    function self.set_y(y)
        self.y = y
    end
    function self.update(dt)
        self.timer = self.timer - dt
        if self.timer <= 0 then
            self.timer = self.fps
            self.currentFrame = self.currentFrame + 1
            if self.currentFrame >  self.quadAccount then self.currentFrame = 1 end
            self.xOffSet = self.size * (self.currentFrame - 1)
            self.quad:setViewport(self.xOffSet, self.y, self.size, self.size)
        end
    end
    function self.draw(args)
        args.x = args.x or 1
        args.y = args.y or 1
        args.xScala = args.xScala or args.scala or 1
        args.yScala = args.yScala or args.scala or 1
        args.rot = args.rot or 0
        love.graphics.draw(self.image, self.quad, args.x-self.size/2, args.y-self.size/2, args.rot, args.xScala, args.yScala)
    end

    return self
end