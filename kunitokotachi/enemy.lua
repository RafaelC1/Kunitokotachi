require "object"
require "helpers"

Enemy = {}

function Enemy.new(args)
  local self = Object.new(args)

  self.kill_points = 100 -- points for kill this enemy
  self.drop = args.drop or 'power'
  self.IA = -- this is the positions that enemy shoud perform during it's life circle
  {
    current_position = 1, -- the current position of it's life circle
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

  -- move enemy acording IA
  function self.move(dt)
    local onX = false
    local onY = false

    if self.IA.current_position > #self.IA.positions then
      self.down(dt)
    end

    if self.body.x < (self.IA.positions[self.IA.current_position].x-2) then
      self.right(dt)
    elseif self.body.x > (self.IA.positions[self.IA.current_position].x+2) then
      self.left(dt)
    else
      onX = true
    end

    if self.body.y < (self.IA.positions[self.IA.current_position].y-2) then
      self.down(dt)
    elseif self.body.y > (self.IA.positions[self.IA.current_position].y+2) then
      self.up(dt)
    else
      onY = true
    end

    if onX and onY then
      if self.IA.positions[self.IA.current_position].action == "shoot" then self.shoot() end
      if self.IA.positions[self.IA.current_position].action == "repeat" then
        self.IA.current_position = 1
      else
        self.IA.current_position = self.IA.current_position + 1
      end
    end
  end
  function self.shoot()
    bullets_controller.create_bullet{x=self.body.x, y=self.body.y-self.body.radio, xv=0, yv=700, type="playerLevel05"}
  end
  -- die and spawm some gift
  function self.is_alive()
    if self.current_hp > 0 then
      return true
    else
      return false
    end
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