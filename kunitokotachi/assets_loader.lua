--file to manager ao sprites on game
-- this controllers doesn't need to be an object doe to this only unic use

require "helpers"
require "sprite"

--images
risoto_tomate_icon = {}
back_ground_sprite = {}
bullets_image = {}
power_ups_images =
{
  ''
}
level_background_images =
{
  ['level01'] = {},
  ['level02'] = {}
}
bullets_sprites =
{
  playerLevel01 = {},
  playerLevel02 = {},
  playerLevel03 = {},
  playerLevel04 = {},
  playerLevel05 = {}
}

default_sprite = {}
ship_sprites = {}
profile_pics =
{
  higuchi = {},
  himiko = {},
  major = {},
  nosinalenus = {},
  secretary = {},
  tomoe = {}
}

life_image = {}

-- fonts
fonts =
{
  normal = {},
  black = {},
  thin = {}
}

-- load images and sprites
function load_all_sprites()
  love.graphics.setDefaultFilter('nearest', 'nearest')
  -- load icons
  risoto_tomate_icon = love.graphics.newImage('res/assets/risototomate_icon.png')
  --load bullets
  bullets_image = love.graphics.newImage('res/assets/bullets/bullets1.png')
  -- load level background image
  level_background_images.level01 = love.graphics.newImage('res/assets/back_ground/BACKGROUNDONE.jpg')

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

  profile_pics.higuchi = love.graphics.newImage(path..'higuchi01.png')
  profile_pics.himiko = love.graphics.newImage(path..'himiko01.png')
  profile_pics.major = love.graphics.newImage(path..'major01.png')
  profile_pics.nosinalenus = love.graphics.newImage(path..'nosignal.png')
  profile_pics.secretary = love.graphics.newImage(path..'secretary.png')
  profile_pics.tomoe = love.graphics.newImage(path..'tomoe01.png')

  life_image = love.graphics.newImage('res/assets/HUD/01.png')

  define_all_sprites()
end

function update(dt)
    -- body
end
function draw()
    -- body
end

function define_all_sprites()
  bullets_sprites.playerLevel01 = Sprite.new(bullets_image, 0, 0, 150, 50, 50, 8)
  bullets_sprites.playerLevel02 = Sprite.new(bullets_image, 0, 50, 150, 50, 50, 8)
  bullets_sprites.playerLevel03 = Sprite.new(bullets_image, 0, 100, 150, 50, 50, 8)
  bullets_sprites.playerLevel04 = Sprite.new(bullets_image, 0, 150, 150, 50, 50, 8)
  bullets_sprites.playerLevel05 = Sprite.new(bullets_image, 0, 200, 150, 50, 50, 10)
  -- PROBLEMAS COM O SPRITE DO BACKGROUND
  -- back_ground_sprite = Sprite.new(backGroundImage, 0, 0, 800, 600, 600, 0)
end

-- load all fonts
function load_all_fonts()
  local path = 'res/fonts/'
  fonts.normal = love.graphics.newFont(path..'roboto-regular.ttf')
  fonts.black = love.graphics.newFont(path..'roboto-black.ttf')
  fonts.thin = love.graphics.newFont(path..'roboto-thin.ttf')
end