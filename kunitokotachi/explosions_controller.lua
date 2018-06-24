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
    local animation = new_explosion_animation() --explosion_animation.copy()
    local new_explosion = Explosion.new(animation, x, y, self.explosion_speed, 0)
    table.insert(self.explosions, new_explosion)

    self.create_explosion_sound_effect()
  end

  function self.create_explosion_sound_effect()
    sfx_controller.play_sound('explosion')
  end

  function self.create_charger_explosion(x, y)
    local charger_side_speed = 200
    local left_animation = new_left_charger_animation()
    local right_animation = new_right_charger_animation()
    local new_left_charger_explosion = Explosion.new(left_animation, x, y, 0, -charger_side_speed)
    local new_right_charger_explosion = Explosion.new(right_animation, x, y, 0, charger_side_speed)
    table.insert(self.explosions, new_left_charger_explosion)
    table.insert(self.explosions, new_right_charger_explosion)
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