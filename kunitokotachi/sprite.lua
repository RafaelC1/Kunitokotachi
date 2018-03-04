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
    x_off_set = 0,
    y_off_set = 0,
    quad = {},
    quad_account = 1, -- acount of colunms of this animation
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
  self.quad_account = self.w / self.size

  self.quad = love.graphics.newQuad(self.x, self.y, self.w, self.h, self.image:getDimensions())

  function self.set_y(y)
    -- self.y = self.y + y
    print(self.y)
  end
  function self.update_view_port()
    self.quad:setViewport(self.x_off_set, self.y, self.size, self.size)
  end
  function self.update(dt)
    self.timer = self.timer - dt
    if self.timer <= 0 then
      self.timer = self.fps
      self.currentFrame = self.currentFrame + 1
      if self.currentFrame >  self.quad_account then self.currentFrame = 1 end
      self.x_off_set = self.size * (self.currentFrame - 1)
      self.update_view_port()
    end
  end
  function self.draw(args)
    args.x = args.x or 1
    args.y = args.y or 1
    args.x_scala = args.x_scala or args.scala or 1
    args.y_scala = args.y_scala or args.scala or 1
    args.rot = args.rot or 0
    love.graphics.draw(self.image, self.quad, args.x, args.y, args.rot, args.x_scala, args.y_scala)
  end
  return self
end