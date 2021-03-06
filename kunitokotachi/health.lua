Health = {}

function Health.new(args)
  local self = {}

  self.max_hp = args.max_hp or 100
  self.current_hp = self.max_hp
  self.invulnerable_time = 0 -- max time of ivulnerability
  self.invulnerable = false

  self.defense = args.defense or 10

  function self.is_alive()
    return self.current_hp > 0
  end

  function self:is_invulnerable()
    return self.invulnerable or self.invulnerable_time > 0
  end

  function self.apply_damage(damage)
    self.current_hp = self.current_hp - damage
  end

  return self
end