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
  player_bullets_image = love.graphics.newImage('res/assets/bullets/player_bullets_v2.png')

-- loading image of life
  life_image = love.graphics.newImage('res/assets/HUD/01.png')

  -- loading image of enemies
  eye_enemy_image = love.graphics.newImage('res/assets/enemies/eye.png')
  return true
end

-- method that create all sprites using quads
function define_sprites()
  -- define explosion sprites
  explosion_sprite.quad_01 = Sprite.new(explosion_image, 0, 0, 100, 100)
  explosion_sprite.quad_02 = Sprite.new(explosion_image, 100, 0, 100, 100)
  explosion_sprite.quad_03 = Sprite.new(explosion_image, 200, 0, 100, 100)
  explosion_sprite.quad_04 = Sprite.new(explosion_image, 300, 0, 100, 100)

  -- bullets sprite
  player_bullets_sprites.player_level_01_sprites.quad_01 = Sprite.new(player_bullets_image, 0, 0, 30, 30)
  player_bullets_sprites.player_level_01_sprites.quad_02 = Sprite.new(player_bullets_image, 30, 0, 30, 30)
  player_bullets_sprites.player_level_01_sprites.quad_03 = Sprite.new(player_bullets_image, 60, 0, 30, 30)

  player_bullets_sprites.player_level_02_sprites.quad_01 = Sprite.new(player_bullets_image, 0, 30, 30, 30)
  player_bullets_sprites.player_level_02_sprites.quad_02 = Sprite.new(player_bullets_image, 30, 30, 30, 30)
  player_bullets_sprites.player_level_02_sprites.quad_03 = Sprite.new(player_bullets_image, 60, 30, 30, 30)

  player_bullets_sprites.player_level_03_sprites.quad_01 = Sprite.new(player_bullets_image, 0, 60, 30, 30)
  player_bullets_sprites.player_level_03_sprites.quad_02 = Sprite.new(player_bullets_image, 30, 60, 30, 30)
  player_bullets_sprites.player_level_03_sprites.quad_03 = Sprite.new(player_bullets_image, 60, 60, 30, 30)

  player_bullets_sprites.player_level_04_sprites.quad_01 = Sprite.new(player_bullets_image, 0, 90, 30, 30)
  player_bullets_sprites.player_level_04_sprites.quad_02 = Sprite.new(player_bullets_image, 30, 90, 30, 30)
  player_bullets_sprites.player_level_04_sprites.quad_03 = Sprite.new(player_bullets_image, 60, 90, 30, 30)

  player_bullets_sprites.player_level_05_sprites.quad_01 = Sprite.new(player_bullets_image, 0, 90, 50, 50)
  player_bullets_sprites.player_level_05_sprites.quad_02 = Sprite.new(player_bullets_image, 50, 90, 50, 50)
  player_bullets_sprites.player_level_05_sprites.quad_03 = Sprite.new(player_bullets_image, 100, 90, 50, 50)
  player_bullets_sprites.player_level_05_sprites.quad_03 = Sprite.new(player_bullets_image, 150, 90, 50, 50)
  player_bullets_sprites.player_level_05_sprites.quad_03 = Sprite.new(player_bullets_image, 200, 90, 50, 50)
  player_bullets_sprites.player_level_05_sprites.quad_03 = Sprite.new(player_bullets_image, 250, 90, 50, 50)

  player_bullets_sprites.player_level_06_sprites.quad_01 = Sprite.new(player_bullets_image, 0, 140, 30, 30)
  player_bullets_sprites.player_level_06_sprites.quad_02 = Sprite.new(player_bullets_image, 30, 140, 30, 30)
  player_bullets_sprites.player_level_06_sprites.quad_03 = Sprite.new(player_bullets_image, 60, 140, 30, 30)

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
  eye_enemy_sprites.normal.quad_01 = Sprite.new(ship_images.ship_03, 0, 0, 40, 100)
  eye_enemy_sprites.normal.quad_02 = Sprite.new(ship_images.ship_03, 40, 0, 40, 100)

  eye_enemy_sprites.attack.quad_01 = Sprite.new(ship_images.ship_03, 0, 100, 40, 100)
  eye_enemy_sprites.attack.quad_02 = Sprite.new(ship_images.ship_03, 40, 100, 40, 100)

  eye_enemy_sprites.die.quad_01 = Sprite.new(ship_images.ship_03, 0, 100, 40, 100)
  eye_enemy_sprites.die.quad_02 = Sprite.new(ship_images.ship_03, 40, 100, 40, 100)

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
  local animations = {}
  local normal_sprites =
  {
    eye_enemy_sprites.normal.quad_01,
    eye_enemy_sprites.normal.quad_02
  }
  local attack_sprites =
  {
    eye_enemy_sprites.attack.quad_01
    eye_enemy_sprites.attack.quad_02
  }
  local die_sprites =
  {
    eye_enemy_sprites.die.quad_01
    eye_enemy_sprites.die.quad_02
  }
  animations.normal = Animation.new(normal_sprites, 0.1)
  animations.attack = Animation.new(attack_sprites, 0.1)
  animations.die = Animation.new(die_sprites, 0.1)

  return all_animations
end

function new_bullet_animation(character, level)
  local sprites = {}
  character = 'player'
  level = 1
  if character == 'player' then
    if level == 1 then
      sprites =
      {
        player_bullets_sprites.player_level_01_sprites.quad_01,
        player_bullets_sprites.player_level_01_sprites.quad_02,
        player_bullets_sprites.player_level_01_sprites.quad_03
      }
      elseif level == 2 then
      sprites =
      {
        player_bullets_sprites.player_level_02_sprites.quad_01,
        player_bullets_sprites.player_level_02_sprites.quad_02,
        player_bullets_sprites.player_level_02_sprites.quad_03
      }
      elseif level == 3 then
      sprites =
      {
        player_bullets_sprites.player_level_03_sprites.quad_01,
        player_bullets_sprites.player_level_03_sprites.quad_02,
        player_bullets_sprites.player_level_03_sprites.quad_03
      }
      elseif level == 4 then
      sprites =
      {
        player_bullets_sprites.player_level_04_sprites.quad_01,
        player_bullets_sprites.player_level_04_sprites.quad_02,
        player_bullets_sprites.player_level_04_sprites.quad_03
      }
      elseif level == 5 then
      sprites =
      {
        player_bullets_sprites.player_level_05_sprites.quad_01,
        player_bullets_sprites.player_level_05_sprites.quad_02,
        player_bullets_sprites.player_level_05_sprites.quad_03,
        player_bullets_sprites.player_level_05_sprites.quad_04,
        player_bullets_sprites.player_level_05_sprites.quad_05,
        player_bullets_sprites.player_level_05_sprites.quad_06
      }
      else
      sprites =
      {
        player_bullets_sprites.player_level_06_sprites.quad_01
      }

      end
  elseif character == 'enemy' then

  end
  return Animation.new(sprites, 0.1)
end

-- load all fonts
function load_all_fonts()
  local path = 'res/fonts/'
  fonts.normal = love.graphics.newFont(path..'roboto-regular.ttf')
  fonts.black = love.graphics.newFont(path..'roboto-black.ttf')
  fonts.thin = love.graphics.newFont(path..'roboto-thin.ttf')
end