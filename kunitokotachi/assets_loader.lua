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

life_image = {}
explosion_image = {}

eye_enemy_image = {}
angel_enemy_image = {}
head_enemy_image = {}
lung_enemy_image = {}

-- sprites
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
  },
}

-- animations
explosion_animation = {}

-- load images and sprites

-- method taht load all image files
function load_all_images()
  love.graphics.setDefaultFilter('nearest', 'nearest')

-- loading game icon
  risoto_tomate_icon = love.image.newImageData('res/assets/risototomate_icon.png')

-- loading explosion image
  explosion_image = love.graphics.newImage('res/assets/fx/explosion.png')

-- loading ships images
  ship_images.ship_01 = love.graphics.newImage('res/assets/ships/shipone.png')
  ship_images.ship_02 = love.graphics.newImage('res/assets/ships/shiptwo.png')
  ship_images.ship_03 = love.graphics.newImage('res/assets/ships/shipthree.png')

  level_background_images.level_01 = love.graphics.newImage('res/assets/back_ground/BACKGROUNDONE.jpg')
  -- level_background_images.level_01 = love.graphics.newImage('res/assets/back_ground/BACKGROUNDONE.jpg')

  -- load all bulet images
  player_bullets_image = love.graphics.newImage('res/assets/bullets/player_bullets.png')

-- loading image of life
  life_image = love.graphics.newImage('res/assets/HUD/01.png')

  -- loading image of enemies
  eye_enemy_image = love.graphics.newImage('res/assets/enemies/eye.png')
  angel_enemy_image = love.graphics.newImage('res/assets/enemies/angel.png')
  head_enemy_image = love.graphics.newImage('res/assets/enemies/head.png')
  lung_enemy_image = love.graphics.newImage('res/assets/enemies/lung.png')

  return true
end

-- method that create all sprites using quads
function define_sprites()
  -- define explosion sprites
  local width = 50
  local height = 50
  local x = 0
  local y = 0

  explosion_sprite.quad_01 = Sprite.new(explosion_image, 0, 0, 100, 100)
  explosion_sprite.quad_02 = Sprite.new(explosion_image, 100, 0, 100, 100)
  explosion_sprite.quad_03 = Sprite.new(explosion_image, 200, 0, 100, 100)
  explosion_sprite.quad_04 = Sprite.new(explosion_image, 300, 0, 100, 100)

  -- bullets sprite
  player_bullets_sprites.player_level_01_sprites.quad_01 = Sprite.new(player_bullets_image, 0, y, width, height)
  player_bullets_sprites.player_level_01_sprites.quad_02 = Sprite.new(player_bullets_image, 50, y, width, height)
  player_bullets_sprites.player_level_01_sprites.quad_03 = Sprite.new(player_bullets_image, 100, y, width, height)
  
  y = y + 50
  player_bullets_sprites.player_level_02_sprites.quad_01 = Sprite.new(player_bullets_image, 0, y, width, height)
  player_bullets_sprites.player_level_02_sprites.quad_02 = Sprite.new(player_bullets_image, 50, y, width, height)
  player_bullets_sprites.player_level_02_sprites.quad_03 = Sprite.new(player_bullets_image, 100, y, width, 35)
  
  y = y + 50
  player_bullets_sprites.player_level_03_sprites.quad_01 = Sprite.new(player_bullets_image, 0, y, width, height)
  player_bullets_sprites.player_level_03_sprites.quad_02 = Sprite.new(player_bullets_image, 50, y, width, height)
  player_bullets_sprites.player_level_03_sprites.quad_03 = Sprite.new(player_bullets_image, 100, y, width, height)
  
  y = y + 50
  player_bullets_sprites.player_level_04_sprites.quad_01 = Sprite.new(player_bullets_image, 0, y, width, height)
  player_bullets_sprites.player_level_04_sprites.quad_02 = Sprite.new(player_bullets_image, 50, y, width, height)
  player_bullets_sprites.player_level_04_sprites.quad_03 = Sprite.new(player_bullets_image, 100, y, width, height)
  
  y = y + 50
  player_bullets_sprites.player_level_05_sprites.quad_01 = Sprite.new(player_bullets_image, 0, y, width, height)
  player_bullets_sprites.player_level_05_sprites.quad_02 = Sprite.new(player_bullets_image, 50, y, width, height)
  player_bullets_sprites.player_level_05_sprites.quad_03 = Sprite.new(player_bullets_image, 100, y, width, height)
  y = y + 50
  player_bullets_sprites.player_level_05_sprites.quad_04 = Sprite.new(player_bullets_image, 0, y, width, height)
  player_bullets_sprites.player_level_05_sprites.quad_05 = Sprite.new(player_bullets_image, 50, y, width, height)
  player_bullets_sprites.player_level_05_sprites.quad_06 = Sprite.new(player_bullets_image, 100, y, width , height)
  
  y = y + 50
  player_bullets_sprites.player_level_06_sprites.quad_01 = Sprite.new(player_bullets_image, 0, y, width, height)

-- ship sprites
  ship_sprites.ship_01.extra_left  = Sprite.new(ship_images.ship_01, 0, 0, 150, 150)
  ship_sprites.ship_01.left        = Sprite.new(ship_images.ship_01, 150, 0, 150, 150)
  ship_sprites.ship_01.center      = Sprite.new(ship_images.ship_01, 285, 0, 150, 150)
  ship_sprites.ship_01.right       = Sprite.new(ship_images.ship_01, 425, 0, 150, 150)
  ship_sprites.ship_01.extra_right = Sprite.new(ship_images.ship_01, 575, 0, 150, 150)

  ship_sprites.ship_02.extra_left  = Sprite.new(ship_images.ship_02, 0, 0, 150, 150)
  ship_sprites.ship_02.left        = Sprite.new(ship_images.ship_02, 150, 0, 150, 150)
  ship_sprites.ship_02.center      = Sprite.new(ship_images.ship_02, 285, 0, 150, 150)
  ship_sprites.ship_02.right       = Sprite.new(ship_images.ship_02, 425, 0, 150, 150)
  ship_sprites.ship_02.extra_right = Sprite.new(ship_images.ship_02, 575, 0, 150, 150)

  ship_sprites.ship_03.extra_left  = Sprite.new(ship_images.ship_03, 0, 0, 150, 150)
  ship_sprites.ship_03.left        = Sprite.new(ship_images.ship_03, 150, 0, 150, 150)
  ship_sprites.ship_03.center      = Sprite.new(ship_images.ship_03, 285, 0, 150, 150)
  ship_sprites.ship_03.right       = Sprite.new(ship_images.ship_03, 425, 0, 150, 150)
  ship_sprites.ship_03.extra_right = Sprite.new(ship_images.ship_03, 575, 0, 150, 150)

  -- enemies sprites
  -- eye
  eye_enemy_sprites.normal.quad_01 = Sprite.new(eye_enemy_image, 0, 0, 40, 100)
  eye_enemy_sprites.normal.quad_02 = Sprite.new(eye_enemy_image, 40, 0, 40, 100)

  eye_enemy_sprites.attack.quad_01 = Sprite.new(eye_enemy_image, 0, 100, 40, 100)
  eye_enemy_sprites.attack.quad_02 = Sprite.new(eye_enemy_image, 40, 100, 40, 100)

  eye_enemy_sprites.die.quad_01 = Sprite.new(eye_enemy_image, 0, 100, 40, 100)
  eye_enemy_sprites.die.quad_02 = Sprite.new(eye_enemy_image, 40, 100, 40, 100)

-- angel
--   angel_enemy_image.normal.quad_01

--   angel_enemy_image.attack.quad_01
--   angel_enemy_image.attack.quad_02

--   angel_enemy_image.die.quad_01

-- -- head
--   head_enemy_image.normal.quad_01
--   head_enemy_image.normal.quad_02
--   head_enemy_image.normal.quad_03

--   head_enemy_image.attack.quad_01

--   head_enemy_image.die.quad_01

-- -- lung
--   lung_enemy_image.normal.quad_01
--   lung_enemy_image.normal.quad_02
--   lung_enemy_image.normal.quad_03
--   lung_enemy_image.normal.quad_04

--   lung_enemy_image.attack.quad_01

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
function new_eye_animations()
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

  return all_animations
end

-- contie animations
function new_angel_animations()
  local all_animations = {}
  local normal_sprites =
  {
  }
  local attack_sprites =
  {
  }
  local die_sprites =
  {
  }
  all_animations.normal = Animation.new(normal_sprites, 0.1)
  all_animations.attack = Animation.new(attack_sprites, 0.1)
  all_animations.die = Animation.new(die_sprites, 0.1)

  return all_animations
end

function new_head_animations()
  local all_animations = {}
  local normal_sprites =
  {
  }
  local attack_sprites =
  {
  }
  local die_sprites =
  {
  }
  all_animations.normal = Animation.new(normal_sprites, 0.1)
  all_animations.attack = Animation.new(attack_sprites, 0.1)
  all_animations.die = Animation.new(die_sprites, 0.1)

  return all_animations
end

function new_lung_animations()
  local all_animations = {}
  local normal_sprites =
  {
  }
  local attack_sprites =
  {
  }
  local die_sprites =
  {
  }
  all_animations.normal = Animation.new(normal_sprites, 0.1)
  all_animations.attack = Animation.new(attack_sprites, 0.1)
  all_animations.die = Animation.new(die_sprites, 0.1)

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

-- load all fonts
function load_all_fonts()
  local path = 'res/fonts/'
  fonts.normal = love.graphics.newFont(path..'roboto-regular.ttf')
  fonts.black = love.graphics.newFont(path..'roboto-black.ttf')
  fonts.thin = love.graphics.newFont(path..'roboto-thin.ttf')
end