require "helpers"
require "bullet"
require "assets_loader"

BulletsController = {}

function BulletsController.new()
  local self =
  {
    bullets_settings = {},
    bullets =
    {
      player = {},
      enemy = {}
    }
  }
  function self.load_bullets_settings()
    self.bullets_settings = json_to_table(read_from('res/settings/bullets_characteristics.json'))
    -- bullets_settings.enemy = read_values_from('res/settings/enemyBullets.json')
  end
    -- spawm a bullet
  function self.create_bullet(x_position,
                              y_position,
                              x_direction,
                              y_direction,
                              bullet_name,
                              owner,
                              owner_title)
    local bullet_settings = self.bullets_settings[bullet_name]

    x_position = x_position or 100
    y_position = y_position or 100
    x_direction = x_direction
    y_direction = y_direction
    speed = bullet_settings.speed

    local scala = 1.5
    local bullet = Bullet.new{sprites=sprite,
                              x=x_position,
                              y=y_position,
                              xv=x_direction,
                              yv=y_direction,
                              speed=speed,
                              damage=bullet_settings.damage,
                              radio=bullet_settings.radio,
                              owner=owner,
                              follow_owner=bullet_settings.follow_owner,
                              destroy_on_impact=bullet_settings.destroyable,
                              sprite_scala=scala,
                              animation=new_bullet_animation(1, 1)}
    table.insert(self.bullets[owner_title], bullet)
    end
  -- check each bullet it it is out of screen so delete it
  function self.check_bullets_position(bullets)
    for i, bullet in ipairs(bullets) do
      if not inside_screen_width(bullet.body.x) or not inside_screen_width(bullet.body.y) then
        self.destroy_bullet(bullets, i, true)
        i = i-1
      end
    end
  end
  function self.has_player_bullets()
    return #self.bullets.player > 0
  end
  function self.has_enemy_bullets()
    return #self.bullets.enemy > 0
  end
    -- destroy a bullet by id
  function self.destroy_bullet(bullets, bulletID, force)
    if bullets[bulletID].destroyable or force then
      table.remove(bullets, bulletID)
    end
  end
  -- destroy all bullets on list
  function self.destroy_all_bullets()
    self.bullets.player = {}
    self.bullets.enemy = {}
  end
  function self.destroy_all_bullets_by_owner(bullets, owner)
    for i, bullet in ipairs(bullets) do
      if bullet.owner == owner then
        self.destroy_bullet(bullets, i, true)
        i = i-1
      end
    end
  end
  function self.update(dt)
    if #self.bullets.player > 0 then
      for i, bullet in ipairs(self.bullets.player) do
        bullet.update(dt)
      end
    end
    if #self.bullets.enemy > 0 then
      for i, bullet in ipairs(self.bullets.enemy) do
        bullet.update(dt)
      end
    end
    self.check_bullets_position(self.bullets)
  end
  function self.draw()
    if #self.bullets.player > 0 then
      for i, bullet in ipairs(self.bullets.player) do
        bullet.draw()
      end
    end
    if #self.bullets.enemy > 0 then
      for i, bullet in ipairs(self.bullets.enemy) do
        bullet.draw()
      end
    end
  end

  self.load_bullets_settings()

  return self
end