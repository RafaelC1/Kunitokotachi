Sprite = {}

-- this sprite just work if all animation sprites are on the same line

function Sprite.new(image, start_x, start_y, width, height)

  local self = {}
  self.quad_width = width
  self.quad_height = height
  self.quad = love.graphics.newQuad(start_x, start_y, self.quad_width, self.quad_height, image:getDimensions())
  self.image = image

  function self.draw(args)
    args.x = args.x or 1
    args.y = args.y or 1
    args.x, args.y = self.adjust_position(args.x, args.y)
    args.x_scala = args.x_scala or args.scala or 1
    args.y_scala = args.y_scala or args.scala or 1
    args.rot = args.rot or 0
    love.graphics.draw(self.image, self.quad, args.x, args.y, args.rot, args.x_scala, args.y_scala)
  end

  function self.adjust_position(x, y)
    local image_width = self.quad_width
    local image_height = self.quad_height
    x = x - image_width/2
    y = y - image_height/2
    return x, y
  end

  return self
end