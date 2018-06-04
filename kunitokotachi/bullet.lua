require "class"
require "body"

Bullet = {}

function Bullet.new(args)
  local self = Class.new()

  self.inherit(Body.new(args))
  self.animation = args.animation

  self.title = 'bullet'

  self.r = 255
  self.g = 0
  self.b = 0

  self.owner = args.owner or nil                    -- who shoot this bullet

  self.damage = args.damage or 20                   -- damage that it inflict on target

  self.xv = args.xv or 10                           -- horizontal moviment -1=left, 1=right
  self.yv = args.yv or 10                           -- vertical moviment -1=up, 1=down

  self.follow_owner = args.follow_owner  or false   -- this bullet shoud follow owner movements?
  self.destroyable = args.destroy_on_impact -- check if bullet destroy it self if touch comething

  self.sprite_scala = args.sprite_scala or 1

  function self.who_shooted()
    return self.owner
  end

  function self.update(dt)
    local current_x = self.xv
    local current_y = self.yv

    -- reduce the speed if bullet move on diagonal
    -- if current_x ~= 0 and current_y ~= 0 then
    --   local total = math.abs(current_x) + math.abs(current_y)
    --   current_x = current_x / total
    --   current_y = current_y / total
    -- end

    current_x = current_x * self.speed * dt
    current_y = current_y * self.speed * dt

    -- this configuration is for move bullet according its owner if this bullet shoud move according it
    if self.follow_owner and self.owner.ship.body then
      if self.owner.keys ~= nil and self.follow_owner then
        if self.owner.ship.speed then
          if love.keyboard.isDown(self.owner.keys.up) then
            current_y = current_y - self.owner.ship.speed*dt
          end
          if love.keyboard.isDown(self.owner.keys.down) then
            current_y = current_y + self.owner.ship.speed*dt
          end
        end
      end
      self.body.x = self.owner.ship.body.x + self.xv*dt
    end

    self.body.x = self.body.x + current_x
    self.body.y = self.body.y + current_y

    self.animation.update(dt)
  end
  function self.draw()
    -- self.draw_test()
    local rot = self.direction_of(self.xv, self.yv)
    -- print(self.xv, self.yv)
    self.animation.draw{x=self.body.x, y=self.body.y, x_scala=1, y_scala=1, rot=0}
  end

  self.animation.start()

  return self
end