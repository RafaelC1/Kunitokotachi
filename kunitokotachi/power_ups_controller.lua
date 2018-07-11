require "power_up"
require "position_helpers"

PowerUpsController = {}

function PowerUpsController.new()
  local self = {}
  self.power_ups_settings = {}
  self.power_ups = {}

  function self.load_bullets_settings()
    self.power_ups_settings = json_to_table(read_from('res/settings/power_ups_settings.json'))
  end
  function self.create_power_up(x, y, power_up_type)
    local power_up_settings = self.power_ups_settings[power_up_type]
    local animation = power_ups_animations['new_'..power_up_settings.animation..'_animation']()
    local power_up = PowerUp.new{x=x,
                                 y=y,
                                 power=power_up_settings.charge_power,
                                 power_type='charge_power',
                                 radio=25,
                                 vanish_time=5,
                                 animation=animation,
                                 speed=50}
    table.insert(self.power_ups, power_up)
  end

  function self.destroy_all_power_ups()
    self.power_ups = {}
  end

  function self.destroy_power_up(power_up_id)
    table.remove(self.power_ups, power_up_id)
  end

  function self.has_power_ups()
    return #self.power_ups > 0
  end

  function self:update(dt)
    for i, power_up in ipairs(self.power_ups) do
      power_up:update(dt)
      if not on_screen(power_up.body.x, power_up.body.y) or power_up.vanished() then
        self.destroy_power_up(i)
      end
    end
  end
  function self.draw()
    for i, power_up in ipairs(self.power_ups) do
      power_up.draw()
    end
  end

  self.load_bullets_settings()

  return self
end
