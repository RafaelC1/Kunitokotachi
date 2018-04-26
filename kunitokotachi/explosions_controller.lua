require "explosion"
require "helpers"

ExplosionsController = {}

function ExplosionsController.new()
  local self = {}
  self.explosions = {}
  self.explosion_speed = 200

  function self.destroy_explosion(explosion_id)
    table.remove(self.explosions, explosion_id)
  end

  function self.destroy_all_explosions()
    self.explosions = {}
  end

  function self.create_explosion(x, y)
    local animation = new_explosion_animation()
    local explosion = Explosion.new(animation, x, y, self.explosion_speed)
    table.insert(self.explosions, explosion)
  end

  function self.update(dt)
    for i, explosion in ipairs(self.explosions) do
      explosion.update(dt)
      if explosion.finished then
        self.destroy_explosion(i)
      end
    end
  end

  function self.draw()
    for i, explosion in ipairs(self.explosions) do
      explosion.draw()
    end
  end

  return self
end