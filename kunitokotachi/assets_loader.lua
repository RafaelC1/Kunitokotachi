--file to manager ao sprites on game
-- this controllers doesn't need to be an object doe to this only unic use

require "helpers"
require "sprite"
require "animation"

-- fonts
fonts =
{
  normal = {},
  black = {},
  thin = {}
}

-- images
explosion_image = {}
ship_images =
{
  ship_01 = {},
  ship_02 = {},
  ship_03 = {}
}

level_background_images =
{
  level_01 = {},
  level_02 = {}
}
player_bullets_image = {}
enemy_bullets_image = {}

life_image = {}
explosion_image = {}
power_ups_image = {}

eye_enemy_image = {}
angel_enemy_image = {}
head_enemy_image = {}
lung_enemy_image = {}

-- sprites
power_ups_sprites =
{
  power_01 = {},
  power_02 = {},
  power_03 = {},
  power_04 = {},
  power_05 = {},
  power_06 = {}
}
explosion_sprite =
{
  quad_01 = {},
  quad_02 = {},
  quad_03 = {},
  quad_04 = {}
}
ship_sprites =
{
  ship_01 =
  {
    extra_left = {},
    left = {},
    center = {},
    right = {},
    extra_right = {}
  },
  ship_02 =
  {
    extra_left = {},
    left = {},
    center = {},
    right = {},
    extra_right = {}
  },
  ship_03 =
  {
    extra_left = {},
    left = {},
    center = {},
    right = {},
    extra_right = {}
  },
}

player_bullets_sprites =
{
  player_level_01_sprites =
  {
    quad_01 = {},
    quad_02 = {},
    quad_03 = {}
  },
  player_level_02_sprites =
  {
    quad_01 = {},
    quad_02 = {},
    quad_03 = {}
  },
  player_level_03_sprites =
  {
    quad_01 = {},
    quad_02 = {},
    quad_03 = {}
  },
  player_level_04_sprites =
  {
    quad_01 = {},
    quad_02 = {},
    quad_03 = {}
  },
  player_level_05_sprites =
  {
    quad_01 = {},
    quad_02 = {},
    quad_03 = {}
  },
  player_level_06_sprites =
  {
    quad_01 = {},
    quad_02 = {},
    quad_03 = {}
  }
}

enemy_bullets_sprites =
{
  small_bullets =
  {
    quad_01 = {},
    quad_02 = {}
  },
  medium_bullets =
  {
    quad_01 = {},
    quad_02 = {}
  },
  laser_bullets =
  {
    quad_01 = {},
    quad_02 = {}
  }
}

eye_enemy_sprites =
{
  attack =
  {
    quad_01 = {},
    quad_02 = {}
  },
  normal =
  {
    quad_01 = {},
    quad_02 = {}
  },
  die =
  {
    quad_01 = {},
    quad_02 = {}
  }
}

angel_enemy_sprite =
{
  attack =
  {
    quad_01 = {}
  },
  normal =
  {
    quad_01 = {},
    quad_02 = {}
  },
  die =
  {
    quad_01 = {}
  }
}

head_enemy_sprite =
{
  attack =
  {
    quad_01 = {},
    quad_02 = {},
    quad_03 = {}
  },
  normal =
  {
    quad_01 = {}
  },
  die =
  {
    quad_01 = {}
  }
}

lung_enemy_sprite =
{
  attack =
  {
    quad_01 = {}
  },
  normal =
  {
    quad_01 = {},
    quad_02 = {},
    quad_03 = {},
    quad_04 = {}
  }
}

life_sprite = {}

-- animations
explosion_animation = {}

-- load images and sprites
local function load_image(path)
  return love.graphics.newImage(path)
end

-- method taht load all image files
function load_all_images()
  love.graphics.setDefaultFilter('nearest', 'nearest')

  -- load gui images
  life_image = load_image('res/assets/HUD/life_image.png')

-- loading game icon
  risoto_tomate_icon = love.image.newImageData('res/assets/risototomate_icon.png')

-- loading explosion image
  explosion_image = load_image('res/assets/fx/explosion.png')

  -- power ups image
  power_ups_image = load_image('res/assets/fx/power_ups.png')

-- loading ships images
  ship_images.ship_01 = load_image('res/assets/ships/shipone.png')
  ship_images.ship_02 = load_image('res/assets/ships/shiptwo.png')
  ship_images.ship_03 = load_image('res/assets/ships/shipthree.png')

  level_background_images.level_01 = load_image('res/assets/back_ground/BACKGROUNDONE.jpg')
  -- level_background_images.level_01 = load_image('res/assets/back_ground/BACKGROUNDONE.jpg')

  -- load all bulet images
  player_bullets_image = load_image('res/assets/bullets/player_bullets.png')
  enemy_bullets_image = load_image('res/assets/bullets/enemy_bullets.png')

  -- loading image of enemies
  eye_enemy_image = load_image('res/assets/enemies/eye.png')
  angel_enemy_image = load_image('res/assets/enemies/angel.png')
  head_enemy_image = load_image('res/assets/enemies/head.png')
  lung_enemy_image = load_image('res/assets/enemies/lung.png')

  return true
end

-- method that create all sprites using quads
function define_sprites()
  -- define explosion sprites
  local width = 50
  local height = 50
  local x = 0
  local y = 0

  -- life sprites
  width = 25
  height = 25
  x = 0
  y = 0
  life_sprite = Sprite.new(life_image, x, y, width, height)

  -- explosion sprites
  width = 100
  height = 100
  x = 0
  y = 0
  explosion_sprite.quad_01 = Sprite.new(explosion_image, 0, y, width, height)
  explosion_sprite.quad_02 = Sprite.new(explosion_image, 100, y, width, height)
  explosion_sprite.quad_03 = Sprite.new(explosion_image, 200, y, width, height)
  explosion_sprite.quad_04 = Sprite.new(explosion_image, 300, y, width, height)

  -- power ups sprites
  width = 50
  height = 75
  x = 0
  y = 0
  power_ups_sprites.power_01 = Sprite.new(power_ups_image, 0, y, width, height)
  power_ups_sprites.power_02 = Sprite.new(power_ups_image, 50, y, width, height)
  power_ups_sprites.power_03 = Sprite.new(power_ups_image, 100, y, width, height)
  power_ups_sprites.power_04 = Sprite.new(power_ups_image, 150, y, width, height)
  power_ups_sprites.power_05 = Sprite.new(power_ups_image, 200, y, width, height)
  power_ups_sprites.power_06 = Sprite.new(power_ups_image, 300, y, width, height)

  -- bullets sprite
  width = 50
  height = 50
  x = 0
  y = 0
  player_bullets_sprites.player_level_01_sprites.quad_01 = Sprite.new(player_bullets_image, 0, y, width, height)
  player_bullets_sprites.player_level_01_sprites.quad_02 = Sprite.new(player_bullets_image, 50, y, width, height)
  player_bullets_sprites.player_level_01_sprites.quad_03 = Sprite.new(player_bullets_image, 100, y, width, height)
  y = y + height
  player_bullets_sprites.player_level_02_sprites.quad_01 = Sprite.new(player_bullets_image, 0, y, width, height)
  player_bullets_sprites.player_level_02_sprites.quad_02 = Sprite.new(player_bullets_image, 50, y, width, height)
  player_bullets_sprites.player_level_02_sprites.quad_03 = Sprite.new(player_bullets_image, 100, y, width, 35)
  y = y + height
  player_bullets_sprites.player_level_03_sprites.quad_01 = Sprite.new(player_bullets_image, 0, y, width, height)
  player_bullets_sprites.player_level_03_sprites.quad_02 = Sprite.new(player_bullets_image, 50, y, width, height)
  player_bullets_sprites.player_level_03_sprites.quad_03 = Sprite.new(player_bullets_image, 100, y, width, height)
  y = y + height
  player_bullets_sprites.player_level_04_sprites.quad_01 = Sprite.new(player_bullets_image, 0, y, width, height)
  player_bullets_sprites.player_level_04_sprites.quad_02 = Sprite.new(player_bullets_image, 50, y, width, height)
  player_bullets_sprites.player_level_04_sprites.quad_03 = Sprite.new(player_bullets_image, 100, y, width, height)
  y = y + height
  player_bullets_sprites.player_level_05_sprites.quad_01 = Sprite.new(player_bullets_image, 0, y, width, height)
  player_bullets_sprites.player_level_05_sprites.quad_02 = Sprite.new(player_bullets_image, 50, y, width, height)
  player_bullets_sprites.player_level_05_sprites.quad_03 = Sprite.new(player_bullets_image, 100, y, width, height)
  y = y + height
  player_bullets_sprites.player_level_05_sprites.quad_04 = Sprite.new(player_bullets_image, 0, y, width, height)
  player_bullets_sprites.player_level_05_sprites.quad_05 = Sprite.new(player_bullets_image, 50, y, width, height)
  player_bullets_sprites.player_level_05_sprites.quad_06 = Sprite.new(player_bullets_image, 100, y, width , height)
  y = y + height
  player_bullets_sprites.player_level_06_sprites.quad_01 = Sprite.new(player_bullets_image, 0, y, width, height)

-- enemy bullets
  width = 100
  height = 100
  x = 0
  y = 0
  enemy_bullets_sprites.small_bullets.quad_01 = Sprite.new(enemy_bullets_image, 0, y, width , height)
  enemy_bullets_sprites.small_bullets.quad_02 = Sprite.new(enemy_bullets_image, 100, y, width , height)

  enemy_bullets_sprites.medium_bullets.quad_01 = Sprite.new(enemy_bullets_image, 200, y, width , height)
  enemy_bullets_sprites.medium_bullets.quad_02 = Sprite.new(enemy_bullets_image, 300, y, width , height)
  y = y + height
  enemy_bullets_sprites.laser_bullets.quad_01 = Sprite.new(enemy_bullets_image, 0, y, width , height)
  enemy_bullets_sprites.laser_bullets.quad_02 = Sprite.new(enemy_bullets_image, 100, y, width , height)

-- ship sprites
  width = 150
  height = 150
  x = nil
  y = 0
  ship_sprites.ship_01.extra_left  = Sprite.new(ship_images.ship_01, 0, y, width, height)
  ship_sprites.ship_01.left        = Sprite.new(ship_images.ship_01, 150, y, width, height)
  ship_sprites.ship_01.center      = Sprite.new(ship_images.ship_01, 285, y, width, height)
  ship_sprites.ship_01.right       = Sprite.new(ship_images.ship_01, 425, y, width, height)
  ship_sprites.ship_01.extra_right = Sprite.new(ship_images.ship_01, 575, y, width, height)

  ship_sprites.ship_02.extra_left  = Sprite.new(ship_images.ship_02, 0, y, width, height)
  ship_sprites.ship_02.left        = Sprite.new(ship_images.ship_02, 150, y, width, height)
  ship_sprites.ship_02.center      = Sprite.new(ship_images.ship_02, 285, y, width, height)
  ship_sprites.ship_02.right       = Sprite.new(ship_images.ship_02, 425, y, width, height)
  ship_sprites.ship_02.extra_right = Sprite.new(ship_images.ship_02, 575, y, width, height)

  ship_sprites.ship_03.extra_left  = Sprite.new(ship_images.ship_03, 0, y, width, height)
  ship_sprites.ship_03.left        = Sprite.new(ship_images.ship_03, 150, y, width, height)
  ship_sprites.ship_03.center      = Sprite.new(ship_images.ship_03, 285, y, width, height)
  ship_sprites.ship_03.right       = Sprite.new(ship_images.ship_03, 425, y, width, height)
  ship_sprites.ship_03.extra_right = Sprite.new(ship_images.ship_03, 575, y, width, height)

  -- enemies sprites
  -- eye
  width = 40
  height = 100
  x = nil
  y = 0
  eye_enemy_sprites.normal.quad_01 = Sprite.new(eye_enemy_image, 0, 0, width, height)
  eye_enemy_sprites.normal.quad_02 = Sprite.new(eye_enemy_image, 40, 0, width, height)
  y = y + height
  eye_enemy_sprites.attack.quad_01 = Sprite.new(eye_enemy_image, 0, y, width, height)
  eye_enemy_sprites.attack.quad_02 = Sprite.new(eye_enemy_image, 40, y, width, height)
  y = y + height
  eye_enemy_sprites.die.quad_01 = Sprite.new(eye_enemy_image, 0, y, width, height)
  eye_enemy_sprites.die.quad_02 = Sprite.new(eye_enemy_image, 40, y, width, height)

-- angel
  width = 75
  height = 75
  x = nil
  y = 0
  angel_enemy_sprite.normal.quad_01 = Sprite.new(angel_enemy_image, 0, y, width, height)
  y = y + height
  angel_enemy_sprite.attack.quad_01 = Sprite.new(angel_enemy_image, 0, y, width, height)
  angel_enemy_sprite.attack.quad_02 = Sprite.new(angel_enemy_image, 75, y, width, height)
  y = y + height
  angel_enemy_sprite.die.quad_01 = Sprite.new(angel_enemy_image, 0, y, width, height)

-- -- head
  width = 100
  height = 100
  x = 0
  y = 0
  head_enemy_sprite.normal.quad_01 = Sprite.new(head_enemy_image, 0, y, width, height)
  head_enemy_sprite.normal.quad_02 = Sprite.new(head_enemy_image, 100, y, width, height)
  head_enemy_sprite.normal.quad_03 = Sprite.new(head_enemy_image, 200, y, width, height)
  y = y + height
  head_enemy_sprite.attack.quad_01 = Sprite.new(head_enemy_image, 0, y, width, height)
  y = y + height
  head_enemy_sprite.die.quad_01 = Sprite.new(head_enemy_image, 0, y, width, height)

-- -- lung
  width = 90
  height = 75
  x = 0
  y = 0
  lung_enemy_sprite.normal.quad_01 = Sprite.new(lung_enemy_image, 0, y, width, height)
  lung_enemy_sprite.normal.quad_02 = Sprite.new(lung_enemy_image, 100, y, width, height)
  lung_enemy_sprite.normal.quad_03 = Sprite.new(lung_enemy_image, 200, y, width, height)
  lung_enemy_sprite.normal.quad_04 = Sprite.new(lung_enemy_image, 300, y, width, height)
  y = y + height
  lung_enemy_sprite.attack.quad_01 = Sprite.new(lung_enemy_image, 0, y, width, height)

  return true
end

-- from here are defined all methods to create animations
function new_explosion_animation()
  local sprites =
  {
    explosion_sprite.quad_01,
    explosion_sprite.quad_02,
    explosion_sprite.quad_03,
    explosion_sprite.quad_04
  }
  return Animation.new(sprites, 0.1)
end

-- animatiosn of enemies should return all animationss on the following order and way
-- as this method bellow does
enemies_animations = {}
function enemies_animations.new_eye_animations()
  local all_animations = {}
  local normal_sprites =
  {
    eye_enemy_sprites.normal.quad_01,
    eye_enemy_sprites.normal.quad_02
  }
  local attack_sprites =
  {
    eye_enemy_sprites.attack.quad_01,
    eye_enemy_sprites.attack.quad_02
  }
  local die_sprites =
  {
    eye_enemy_sprites.die.quad_01,
    eye_enemy_sprites.die.quad_02
  }
  all_animations.normal = Animation.new(normal_sprites, 0.1)
  all_animations.attack = Animation.new(attack_sprites, 0.1)
  all_animations.die = Animation.new(die_sprites, 0.1)

  all_animations.attack.dont_repeat()
  all_animations.die.dont_repeat()

  return all_animations
end

-- contie animations
function enemies_animations.new_angel_animations()
  local all_animations = {}
  local normal_sprites =
  {
    angel_enemy_sprite.normal.quad_01
  }
  local attack_sprites =
  {
    angel_enemy_sprite.attack.quad_01,
    angel_enemy_sprite.attack.quad_02
  }
  local die_sprites =
  {
    angel_enemy_sprite.die.quad_01
  }
  all_animations.normal = Animation.new(normal_sprites, 0.1)
  all_animations.attack = Animation.new(attack_sprites, 0.1)
  all_animations.die = Animation.new(die_sprites, 0.1)

  all_animations.attack.dont_repeat()
  all_animations.die.dont_repeat()

  return all_animations
end

function enemies_animations.new_head_animations()
  local all_animations = {}
  local normal_sprites =
  {
    head_enemy_sprite.normal.quad_01,
    head_enemy_sprite.normal.quad_02,
    head_enemy_sprite.normal.quad_03
  }
  local attack_sprites =
  {
    head_enemy_sprite.attack.quad_01
  }
  local die_sprites =
  {
    head_enemy_sprite.die.quad_01
  }
  all_animations.normal = Animation.new(normal_sprites, 0.3)
  all_animations.attack = Animation.new(attack_sprites, 0.2)
  all_animations.die = Animation.new(die_sprites, 0.1)

  all_animations.attack.dont_repeat()
  all_animations.die.dont_repeat()

  return all_animations
end

function enemies_animations.new_lung_animations()
  local all_animations = {}
  local normal_sprites =
  {
    lung_enemy_sprite.normal.quad_01,
    lung_enemy_sprite.normal.quad_02,
    lung_enemy_sprite.normal.quad_03,
    lung_enemy_sprite.normal.quad_04
  }
  local attack_sprites =
  {
    lung_enemy_sprite.attack.quad_01
  }
  local die_sprites = nil

  all_animations.normal = Animation.new(normal_sprites, 0.15)
  all_animations.attack = Animation.new(attack_sprites, 0.2)
  all_animations.die = nil

  all_animations.attack.dont_repeat()

  return all_animations
end


bullet_animations = {}
-- one lasers
function bullet_animations.new_player_level_01_animation()
  local sprites =
  {
    player_bullets_sprites.player_level_01_sprites.quad_01,
    player_bullets_sprites.player_level_01_sprites.quad_02,
    player_bullets_sprites.player_level_01_sprites.quad_03
  }
  return Animation.new(sprites, 0.05)
end
-- two lasers
function bullet_animations.new_player_level_02_animation()
  local sprites =
  {
    player_bullets_sprites.player_level_02_sprites.quad_01,
    player_bullets_sprites.player_level_02_sprites.quad_02,
    player_bullets_sprites.player_level_02_sprites.quad_03
  }
  return Animation.new(sprites, 0.05)
end
-- three lasers
function bullet_animations.new_player_level_03_animation()
  local sprites =
  {
    player_bullets_sprites.player_level_03_sprites.quad_01,
    player_bullets_sprites.player_level_03_sprites.quad_02,
    player_bullets_sprites.player_level_03_sprites.quad_03
  }
  return Animation.new(sprites, 0.05)
end
-- balls
function bullet_animations.new_player_level_04_animation()
  local sprites =
  {
    player_bullets_sprites.player_level_04_sprites.quad_01,
    player_bullets_sprites.player_level_04_sprites.quad_02,
    player_bullets_sprites.player_level_04_sprites.quad_03
  }
  return Animation.new(sprites, 0.05)
end
-- single lasers
function bullet_animations.new_player_level_05_animation()
  local sprites =
  {
    player_bullets_sprites.player_level_05_sprites.quad_01,
    player_bullets_sprites.player_level_05_sprites.quad_02,
    player_bullets_sprites.player_level_05_sprites.quad_03,
    player_bullets_sprites.player_level_05_sprites.quad_04,
    player_bullets_sprites.player_level_05_sprites.quad_05,
    player_bullets_sprites.player_level_05_sprites.quad_06
  }
  return Animation.new(sprites, 0.02)
end
-- bomb
function bullet_animations.new_player_level_06_animation()
  local sprites =
  {
    player_bullets_sprites.player_level_06_sprites.quad_01
  }
  return Animation.new(sprites, 1)
end

function bullet_animations.new_small_bullet_animation()
  local sprites =
  {
    enemy_bullets_sprites.small_bullets.quad_01,
    enemy_bullets_sprites.small_bullets.quad_02
  }
  return Animation.new(sprites, 0.2)
end

function bullet_animations.new_medium_bullet_animation()
  local sprites =
  {
    enemy_bullets_sprites.medium_bullets.quad_01,
    enemy_bullets_sprites.medium_bullets.quad_02
  }
  return Animation.new(sprites, 0.2)
end

function bullet_animations.new_laser_bullet_animation()
  local sprites =
  {
    enemy_bullets_sprites.laser_bullets.quad_01,
    enemy_bullets_sprites.laser_bullets.quad_02
  }
  return Animation.new(sprites, 0.2)
end

power_ups_animations = {}

function power_ups_animations.new_power_01_animation()
  local sprites =
  {
    power_ups_sprites.power_01
  }
  return Animation.new(sprites, 0.2)
end

function power_ups_animations.power_02()
  local sprites =
  {
    power_ups_sprites.power_02
  }
  return Animation.new(sprites, 0.2)
end

function power_ups_animations.power_03()
  local sprites =
  {
    power_ups_sprites.power_03
  }
  return Animation.new(sprites, 0.2)
end

function power_ups_animations.power_04()
  local sprites =
  {
    power_ups_sprites.power_04
  }
  return Animation.new(sprites, 0.2)
end

function power_ups_animations.power_05()
  local sprites =
  {
    power_ups_sprites.power_05
  }
  return Animation.new(sprites, 0.2)
end

function power_ups_animations.power_06()
  local sprites =
  {
    power_ups_sprites.power_06
  }
  return Animation.new(sprites, 0.2)
end

-- load all fonts
function load_all_fonts()
  local path = 'res/fonts/'
  fonts.normal = love.graphics.newFont(path..'roboto-regular.ttf')
  fonts.black = love.graphics.newFont(path..'roboto-black.ttf')
  fonts.thin = love.graphics.newFont(path..'roboto-thin.ttf')
end
