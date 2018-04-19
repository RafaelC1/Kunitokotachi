--file to manager ao sprites on game
-- this controllers doesn't need to be an object doe to this only unic use

require "helpers"
require "sprite"
require "animation"

--images

risoto_tomate_icon = {}
game_logo = {}

bullets_image = {}
power_ups_images =
{
  ''
}
level_background_images =
{
  ['level_01'] = {},
  ['level_02'] = {}
}
profile_image =
{
  higuchi = {},
  himiko = {},
  major = {},
  nosinalenus = {},
  secretary = {},
  tomoe = {}
}
life_image = {}
explosion_image = {}

-- sprites

bullets_sprites =
{
  player_level_01_sprite = {},
  player_level_02_sprite = {},
  player_level_03_sprite = {},
  player_level_04_sprite = {},
  player_level_05_sprite = {}
}
default_sprite = {}
ship_sprites = {}
explosion_sprites = {}


-- fonts
fonts =
{
  normal = {},
  black = {},
  thin = {}
}

-- load images and sprites OLD
function load_all_sprites()
  love.graphics.setDefaultFilter('nearest', 'nearest')
  -- load icons
  risoto_tomate_icon = love.graphics.newImage('res/assets/risototomate_icon.png')
  --load bullets
  bullets_image = love.graphics.newImage('res/assets/bullets/bullets1.png')
  -- load level background image
  level_background_images.level_01 = love.graphics.newImage('res/assets/back_ground/BACKGROUNDONE.jpg')


  --load players
  local path = "res/assets/HUD/01.png"

  default_sprite = love.graphics.newImage(path)

  for i, folder in ipairs({"one", "two", "three"}) do
    ship_sprites[i] = {}
    for j = 1, 5 do
      path = string.format("res/assets/ships/%s/%02d.png", folder, i)
      ship_sprites[i][j] = love.graphics.newImage(path)
    end
  end

  path = 'res/assets/portraits/profile/'

  profile_image.higuchi = love.graphics.newImage(path..'higuchi01.png')
  profile_image.himiko = love.graphics.newImage(path..'himiko01.png')
  profile_image.major = love.graphics.newImage(path..'major01.png')
  profile_image.nosinalenus = love.graphics.newImage(path..'nosignal.png')
  profile_image.secretary = love.graphics.newImage(path..'secretary.png')
  profile_image.tomoe = love.graphics.newImage(path..'tomoe01.png')

  life_image = love.graphics.newImage('res/assets/HUD/01.png')

  explosion_image = love.graphics.newImage('res/assets/fx/explosion.png')

  define_all_sprites()

  -- CURRENT_SCREEN = SCREENS.MAIN_MENU_SCREEN
  return true

end

function update(dt)
    -- body
end
function draw()
    -- body
end

function define_all_sprites()
  bullets_sprites.player_level01_sprite = Sprite.new(bullets_image, 0, 0, 150, 50, 50, 8)
  bullets_sprites.player_level02_sprite = Sprite.new(bullets_image, 0, 50, 150, 50, 50, 8)
  bullets_sprites.player_level03_sprite = Sprite.new(bullets_image, 0, 100, 150, 50, 50, 8)
  bullets_sprites.player_level04_sprite = Sprite.new(bullets_image, 0, 150, 150, 50, 50, 8)
  bullets_sprites.player_level05_sprite = Sprite.new(bullets_image, 0, 200, 150, 50, 50, 10)

  explosion_sprites = Sprite.new(explosion_image, 0, 0, 100, 100, 100, 4)
  -- PROBLEMAS COM O SPRITE DO BACKGROUND
end

-- load all fonts
function load_all_fonts()
  local path = 'res/fonts/'
  fonts.normal = love.graphics.newFont(path..'roboto-regular.ttf')
  fonts.black = love.graphics.newFont(path..'roboto-black.ttf')
  fonts.thin = love.graphics.newFont(path..'roboto-thin.ttf')
end

-- images
explosion_image = {}

-- sprites
explosion_sprite =
{
  quad_01 = {},
  quad_02 = {},
  quad_03 = {},
  quad_04 = {}
}

-- load images and sprites NEW

-- method taht load all image files
function load_all_images()
  explosion_image = love.graphics.newImage('res/assets/fx/explosion.png')
end

-- method that create all sprites using quads
function define_sprites()
  explosion_sprite.quad_01 = Sprite.new(explosion_image, 0, 0, 100, 100)
  explosion_sprite.quad_02 = Sprite.new(explosion_image, 100, 0, 100, 100)
  explosion_sprite.quad_03 = Sprite.new(explosion_image, 200, 0, 100, 100)
  explosion_sprite.quad_04 = Sprite.new(explosion_image, 300, 0, 100, 100)
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