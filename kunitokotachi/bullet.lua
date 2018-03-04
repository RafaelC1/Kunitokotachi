require "object"

Bullet = {}

function Bullet.new(args)
  local self = Object.new(args)
  
  self.owner = args.owner or nil                  -- who shoot this bullet
  self.xv = args.xv or 10                         -- horizontal moviment -1=left, 1=right
  self.yv = args.yv or 10                         -- vertical moviment -1=up, 1=down
  self.damage = args.damage or 20                 -- damage that it inflict on target
  self.follow_owner = args.follow_owner  or false   -- this bullet shoud follow owner movements?
  self.destroyable = args.destroy_on_impact -- check if bullet destroy it self if touch comething
  self.sprite_scala = args.sprite_scala or 1  

  function self.update(dt)
    local current_y = 0
    current_y = self.yv*dt
    -- this configuration is for move bullet according its owner if this bullet shoud move according it
    if self.follow_owner then
      if self.owner.keys ~= nil and self.follow_owner then
        if love.keyboard.isDown(self.owner.keys.up) then
          current_y = current_y - self.owner.ship.speed*dt
        end
        if love.keyboard.isDown(self.owner.keys.down) then
          current_y = current_y + self.owner.ship.speed*dt
        end
      end
      self.body.x = self.owner.ship.body.x + self.xv*dt
    end
    self.body.y = self.body.y + current_y
    self.sprite.update(dt)
  end
  function self.draw()
    local scala = 1.5 -- self.body.radio
    self.sprite.draw{x=self.body.x-self.sprite.size*scala/2, y=self.body.y-self.sprite.size*scala/2, scala=scala}
  end
  return self
end