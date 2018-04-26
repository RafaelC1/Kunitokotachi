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
  {}
}
player_bullets_sprites =
{
  player_level_01_sprites =
  {
    quad_01 = {},
    quad_02 = {},
    quad_03 = {}
  },
}

-- load images and sprites NEW

-- method taht load all image files
function load_all_images()
  love.graphics.setDefaultFilter('nearest', 'nearest')

-- loading game icon
  risoto_tomate_icon = love.image.newImageData('res/assets/risototomate_icon.png')

-- loading explosion image
  explosion_image = love.graphics.newImage('res/assets/fx/explosion.png')

-- loading ships images
  ship_images.ship_01 = love.graphics.newImage('res/assets/ships/one/01.png')

  level_background_images.level_01 = love.graphics.newImage('res/assets/back_ground/BACKGROUNDONE.jpg')
  -- level_background_images.level_01 = love.graphics.newImage('res/assets/back_ground/BACKGROUNDONE.jpg')

  -- load all bulet images
  player_bullets_image = love.graphics.newImage('res/assets/bullets/player_bullets.png')

-- loading image of life
  life_image = love.graphics.newImage('res/assets/HUD/01.png')
  return true
end

-- method that create all sprites using quads
function define_sprites()
  explosion_sprite.quad_01 = Sprite.new(explosion_image, 0, 0, 100, 100)
  explosion_sprite.quad_02 = Sprite.new(explosion_image, 100, 0, 100, 100)
  explosion_sprite.quad_03 = Sprite.new(explosion_image, 200, 0, 100, 100)
  explosion_sprite.quad_04 = Sprite.new(explosion_image, 300, 0, 100, 100)

  ship_sprites[1][1] = Sprite.new(ship_images.ship_01, 0, 0, 100, 100)

  player_bullets_sprites.player_level_01_sprites.quad_01 = Sprite.new(player_bullets_image, 0, 0, 30, 30)
  player_bullets_sprites.player_level_01_sprites.quad_02 = Sprite.new(player_bullets_image, 100, 0, 30, 30)
  player_bullets_sprites.player_level_01_sprites.quad_03 = Sprite.new(player_bullets_image, 200, 0, 30, 30)

  player_bullets_sprites.player_level_02_sprites.quad_01 = Sprite.new(player_bullets_image, 0, 100, 30, 30)
  player_bullets_sprites.player_level_02_sprites.quad_02 = Sprite.new(player_bullets_image, 100, 100, 30, 30)
  player_bullets_sprites.player_level_02_sprites.quad_03 = Sprite.new(player_bullets_image, 200, 100, 30, 30)

  player_bullets_sprites.player_level_03_sprites.quad_01 = Sprite.new(player_bullets_image, 0, 200, 30, 30)
  player_bullets_sprites.player_level_03_sprites.quad_02 = Sprite.new(player_bullets_image, 100, 200, 30, 30)
  player_bullets_sprites.player_level_03_sprites.quad_03 = Sprite.new(player_bullets_image, 200, 200, 30, 30)

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
  return Animation.new(sprites, 0.2)
end

function new_bullet_animation(character, level)
  local sprites = {}
  character = 'player'
  level = 1
  if character == 'player' then
    sprites =
    {
      player_bullets_sprites[string.format("player_level_%02d_sprites", level)].quad_01,
      player_bullets_sprites[string.format("player_level_%02d_sprites", level)].quad_02,
      player_bullets_sprites[string.format("player_level_%02d_sprites", level)].quad_03
    }
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