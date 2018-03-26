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
    power_up_type = 'power'
    local power_up_settings = self.power_ups_settings[power_up_type]
    local power_up = PowerUp.new{x=x, y=y, power=power_up_settings.charge_power, power_type='power', radio=30, vanish_on_time=3, speed=200}
    table.insert(self.power_ups, power_up)
  end
  function self.destroy_power_up(power_up_id)
    table.remove(self.power_ups, power_up_id)
  end
  function self.has_power_ups()
    return #self.power_ups > 0
  end
  function self.update(dt)
    for i, power_up in ipairs(self.power_ups) do
      power_up.update(dt)
      if not on_screen(power_up.body.x, power_up.body.y) then
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