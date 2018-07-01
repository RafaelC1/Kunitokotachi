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
font_sizes =
{
  tiny = 10,
  normal = 14,
  big = 18,
  extra_big = 22
}

-- images
cut_scenes_images = {}
avatars =
{
  higuchi =
  {
    normal = {},
    speaking = {},
    angry = {}
  },
  himiko =
  {
    normal = {},
    speaking = {},
    angry = {}
  },
  major =
  {
    normal = {},
    speaking = {},
    angry = {}
  },
  no_signal =
  {
    normal = {},
  },
  secretary =
  {
    normal = {},
  },
  tomoe =
  {
    normal = {},
    scary = {},
    crazy = {}
  }
}
boss_images =
{
  boss_01 = {},
  boss_02 = {}
}
debris_image = {}
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
charger_image = {}
hud_bar_image = {}
power_ups_image = {}

eye_enemy_image = {}
angel_enemy_image = {}
head_enemy_image = {}
lung_enemy_image = {}
fish_enemy_image = {}
romancer_enemy_image = {}
head2_enemy_image = {}
mermaid_enemy_image = {}

-- sprites
cut_scenes_sprites = {}
boss_sprites =
{
  boss_01 =
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
  },
  boss_02 =
  {
    level_01 =
    {
      attack = {},
      normal = {},
      die = {}
    },
    level_02 =
    {
      attack = {},
      normal = {},
      die = {}
    }
  }
}
hud_bar_sprites =
{
  charge_lvl_01 = {},
  charge_lvl_02 = {},
  charge_lvl_03 = {},
  charge_lvl_04 = {},
  charge_lvl_05 = {},
  charge_lvl_06 = {}
}
charger_sprites =
{
  left =
  {
    quad_01,
    quad_02,
  },
  right =
  {
    quad_01,
    quad_02,
  }
}

debris_sprites =
{
  debri_01 = {},
  debri_02 = {},
  debri_03 = {},
  debri_04 = {},
  debri_05 = {},
  debri_06 = {},
  debri_07 = {}
}
level_background_sprites =
{
  level_01_sprites = {},
  level_02_sprites = {}
}
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

fish_enemy_sprite = 
{
  normal =
  {
    quad_01 = {},
    quad_02 = {},
  }
}

head2_enemy_sprite =
{
  normal = 
  {
    quad_01 ={}
  }
}

mermaid_enemy_sprite =
{
  normal =
  {
    quad_01 = {},
    quad_02 = {},
  }
}

romancer_enemy_sprite =
{
  normal =
  {
    quad_01 = {}
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

  -- load all cut scenes
  local cut_scenes_images_ids_group = {6, 5, 1, 4, 1, 2, 1, 3, 3}
  for group_id=1, #cut_scenes_images_ids_group, 1 do

    cut_scenes_images[group_id] = {}
    for image_id=1, cut_scenes_images_ids_group[group_id], 1 do
      local path = string.format("res/assets/cut_scenes/%02d/%02d.jpg",
                                  group_id,
                                  image_id)
      cut_scenes_images[group_id][image_id] = load_image(path)
    end

  end

  -- load all avatars
  local avatar_path = 'res/assets/portraits/profile/'
  avatars.higuchi.normal = load_image(avatar_path..'higuchi01.png')
  avatars.higuchi.speaking = load_image(avatar_path..'higuchi02.png')
  avatars.higuchi.angry = load_image(avatar_path..'higuchi03.png')

  avatars.himiko.normal = load_image(avatar_path..'himiko01.png')
  avatars.himiko.speaking = load_image(avatar_path..'himiko02.png')
  avatars.himiko.angry = load_image(avatar_path..'himiko03.png')

  avatars.major.normal = load_image(avatar_path..'major01.png')
  avatars.major.speaking = load_image(avatar_path..'major02.png')
  avatars.major.angry = load_image(avatar_path..'major03.png')

  avatars.no_signal.normal = load_image(avatar_path..'nosignal.png')

  avatars.secretary.normal = load_image(avatar_path..'secretary.png')

  avatars.tomoe.normal = load_image(avatar_path..'tomoe01.png')
  avatars.tomoe.scary = load_image(avatar_path..'tomoe02.png')
  avatars.tomoe.crazy = load_image(avatar_path..'tomoe03.png')

  -- load all bosses images
  boss_images.boss_01 = load_image('res/assets/enemies/boss_01.png')
  boss_images.boss_02 = load_image('res/assets/enemies/boss_02.png')

  -- load debris
  debris_image = load_image('res/assets/debris/debris.png')

  -- load hud
  hud_bar_image = load_image('res/assets/HUD/hud_bar.png')

  -- load gui images
  life_image = load_image('res/assets/HUD/life_image.png')

-- loading game icon
  risoto_tomate_icon = love.image.newImageData('res/assets/risototomate_icon.png')

-- loading explosion image
  explosion_image = load_image('res/assets/fx/explosion.png')

-- load charger image
  charger_image = load_image('res/assets/fx/charge.png')

  -- power ups image
  power_ups_image = load_image('res/assets/fx/power_ups.png')

-- loading ships images
  ship_images.ship_01 = load_image('res/assets/ships/shipone.png')
  ship_images.ship_02 = load_image('res/assets/ships/shiptwo.png')
  ship_images.ship_03 = load_image('res/assets/ships/shipthree.png')

  level_background_images.level_01 = load_image('res/assets/back_ground/level_01_background_v1.jpg')
  level_background_images.level_02 = load_image('res/assets/back_ground/level_01_background_v1.jpg')

  -- load all bulet images
  player_bullets_image = load_image('res/assets/bullets/player_bullets.png')
  enemy_bullets_image = load_image('res/assets/bullets/enemy_bullets.png')

  -- loading image of enemies
  local enemy_path = 'res/assets/enemies/'
  eye_enemy_image = load_image(enemy_path..'eye.png')
  angel_enemy_image = load_image(enemy_path..'angel.png')
  head_enemy_image = load_image(enemy_path..'head.png')
  lung_enemy_image = load_image(enemy_path..'lung.png')
  fish_enemy_image = load_image(enemy_path..'fish.png')
  romancer_enemy_image = load_image(enemy_path..'romancer.png')
  head2_enemy_image = load_image(enemy_path..'head_2.png')
  mermaid_enemy_image = load_image(enemy_path..'mermaid.png')

  return true
end

-- method that create all sprites using quads
function define_sprites()
  -- define explosion sprites
  local width = 50
  local height = 50
  local x = 0
  local y = 0

  -- define all cut scenes sprites
  local cut_scenes_images_ids_group = {6, 5, 1, 4, 1, 2, 1, 3, 3}
  for group_id=1, #cut_scenes_images_ids_group, 1 do

    cut_scenes_sprites[group_id] = {}
    for image_id=1, cut_scenes_images_ids_group[group_id], 1 do
      local path = string.format("res/assets/cut_scenes/%02d/%02d.jpg",
                                  group_id,
                                  image_id)
      local start_x, start_y = 0, 0
      local cut_scene_width, cut_scene_height = 800, 300
      local new_sprite = Sprite.new(cut_scenes_images[group_id][image_id],
                                    start_x,
                                    start_y,
                                    cut_scene_width,
                                    cut_scene_height)
      cut_scenes_sprites[group_id][image_id] = new_sprite
    end

  end

  -- define all bosses sprites
  -- boss 01
  width = 660
  height = 440
  x = 0
  y = 0

  boss_sprites.boss_01.normal.quad_01 = Sprite.new(boss_images.boss_01, x, y, width, height)
  x = x + width
  boss_sprites.boss_01.normal.quad_02 = Sprite.new(boss_images.boss_01, x, y, width, height)
  x = x + width
  boss_sprites.boss_01.normal.quad_02 = Sprite.new(boss_images.boss_01, x, y, width, height)
  x = 0
  y = y + height
  boss_sprites.boss_01.attack.quad_01 = Sprite.new(boss_images.boss_01, x, y, width, height)
  x = x + width
  boss_sprites.boss_01.attack.quad_02 = Sprite.new(boss_images.boss_01, x, y, width, height)

  -- boss 02
  width = 650
  height = 500
  x = 0
  y = 0

  boss_sprites.boss_02.level_01.normal.quad_01 = Sprite.new(boss_images.boss_02, x, y, width, height)
  x = x + width
  boss_sprites.boss_02.level_01.normal.quad_02 = Sprite.new(boss_images.boss_02, x, y, width, height)

  x = 0
  y = y + height
  boss_sprites.boss_02.level_02.normal.quad_01 = Sprite.new(boss_images.boss_02, x, y, width, height)
  x = x + width
  boss_sprites.boss_02.level_02.normal.quad_02 = Sprite.new(boss_images.boss_02, x, y, width, height)

  -- background sprites
  level_background_sprites.level_01_sprites = define_back_ground_sprites(level_background_images.level_01)
  level_background_sprites.level_02_sprites = define_back_ground_sprites(level_background_images.level_02)

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

  -- fish
  width = 100
  height = 100
  x = 0
  y = 0
  fish_enemy_sprite.normal.quad_01 = Sprite.new(fish_enemy_image, 0, y, width, height)
  fish_enemy_sprite.normal.quad_02 = Sprite.new(fish_enemy_image, 100, y, width, height)

  -- romancer
  width = 100
  height = 100
  x = 0
  y = 0
  romancer_enemy_sprite.normal.quad_01 = Sprite.new(romancer_enemy_image, 0, y, width, height)

  -- head 2
  width = 100
  height = 100
  x = 0
  y = 0
  head2_enemy_sprite.normal.quad_01 = Sprite.new(head2_enemy_image, 0, y, width, height)

  -- mermaid
  width = 100
  height = 100
  x = 0
  y = 0
  mermaid_enemy_sprite.normal.quad_01 = Sprite.new(mermaid_enemy_image, 0, y, width, height)
  mermaid_enemy_sprite.normal.quad_02 = Sprite.new(mermaid_enemy_image, 100, y, width, height)

-- define all debris sprites
  width = 100
  height = 100
  x = 0
  y = 0
  debris_sprites.debri_01 = Sprite.new(debris_image, x, y, width, height)
  x = x + width
  debris_sprites.debri_02 = Sprite.new(debris_image, x, y, width, height)
  x = x + width
  debris_sprites.debri_03 = Sprite.new(debris_image, x, y, width, height)
  x = x + width
  debris_sprites.debri_04 = Sprite.new(debris_image, x, y, width, height)
  x = x + width
  debris_sprites.debri_05 = Sprite.new(debris_image, x, y, width, height)
  x = x + width
  debris_sprites.debri_06 = Sprite.new(debris_image, x, y, width, height)
  x = x + width
  debris_sprites.debri_07 = Sprite.new(debris_image, x, y, width, height)

  -- define all chargers sprite
  width = 90
  height = 90
  x = 0
  y = 0

  charger_sprites.right.quad_01 = Sprite.new(charger_image, x, y, width, height)
  x = x + width
  charger_sprites.right.quad_02 = Sprite.new(charger_image, x, y, width, height)
  x = 0
  y = y + height
  charger_sprites.left.quad_01 = Sprite.new(charger_image, x, y, width, height)
  x = x + width
  charger_sprites.left.quad_02 = Sprite.new(charger_image, x, y, width, height)

  -- define hud sprites
  width = 150
  height = 50
  x = 0
  y = 0

  hud_bar_sprites.charge_lvl_01 = Sprite.new(hud_bar_image, x, y, width, height)
  x = x + width
  hud_bar_sprites.charge_lvl_02 = Sprite.new(hud_bar_image, x, y, width, height)
  x = x + width
  hud_bar_sprites.charge_lvl_03 = Sprite.new(hud_bar_image, x, y, width, height)
  x = x + width
  hud_bar_sprites.charge_lvl_04 = Sprite.new(hud_bar_image, x, y, width, height)
  x = x + width
  hud_bar_sprites.charge_lvl_05 = Sprite.new(hud_bar_image, x, y, width, height)
  x = x + width
  hud_bar_sprites.charge_lvl_06 = Sprite.new(hud_bar_image, x, y, width, height)

  return true
end

function define_back_ground_sprites(image)
  local sprites = {}

  local image_width, image_height = image:getDimensions()
  local extra_sprite_height = image_height % HEIGHT
  local amount_of_sprites = (image_height - extra_sprite_height) / HEIGHT

  local current_height = HEIGHT

  for i=1, amount_of_sprites do
    local new_sprite = Sprite.new(image, 0, (current_height*i), WIDTH, HEIGHT)
    sprites[i] = new_sprite
  end

  if extra_sprite_height > 0 then
    current_height = current_height+extra_sprite_height
    local new_sprite = Sprite.new(image, current_height, 0, WIDTH, extra_sprite_height)
    table.insert(sprites, new_sprite)
  end

  local reverse_sprites = {}

  for i=amount_of_sprites, 1, -1 do
    reverse_sprites[#reverse_sprites+1] = sprites[i]
  end

  return reverse_sprites
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

function enemies_animations.new_fish_animations()
  local all_animations = {}
  local normal_sprites =
  {
    fish_enemy_sprite.normal.quad_01,
    fish_enemy_sprite.normal.quad_02
  }
  local attack_sprites = nil
  local die_sprites = nil

  all_animations.normal = Animation.new(normal_sprites, 0.15)
  all_animations.attack = nil
  all_animations.die = nil

  return all_animations
end

function enemies_animations.new_romancer_animations()
  local all_animations = {}
  local normal_sprites =
  {
    romancer_enemy_sprite.normal.quad_01
  }
  local attack_sprites = nil
  local die_sprites = nil

  all_animations.normal = Animation.new(normal_sprites, 0.15)
  all_animations.attack = nil
  all_animations.die = nil

  return all_animations
end

function enemies_animations.new_head2_animations()
  local all_animations = {}
  local normal_sprites =
  {
    head2_enemy_sprite.normal.quad_01
  }
  local attack_sprites = nil
  local die_sprites = nil

  all_animations.normal = Animation.new(normal_sprites, 0.15)
  all_animations.attack = nil
  all_animations.die = nil

  return all_animations
end

function enemies_animations.new_mermaid_animations()
  local all_animations = {}
  local normal_sprites =
  {
    mermaid_enemy_sprite.normal.quad_01,
    mermaid_enemy_sprite.normal.quad_02
  }
  local attack_sprites = nil
  local die_sprites = nil

  all_animations.normal = Animation.new(normal_sprites, 0.15)
  all_animations.attack = nil
  all_animations.die = nil

  return all_animations
end

function enemies_animations.new_boss_01_animations()
  local all_animations = {}
  local normal_sprites =
  {
    boss_sprites.boss_01.normal.quad_01,
    boss_sprites.boss_01.normal.quad_02,
    boss_sprites.boss_01.normal.quad_03
  }
  local attack_sprites =
  {
    boss_sprites.boss_01.attack.quad_01,
    boss_sprites.boss_01.attack.quad_02,
  }
  local die_sprites = nil

  all_animations.normal = Animation.new(normal_sprites, 0.15)
  all_animations.attack = Animation.new(attack_sprites, 0.2)
  all_animations.die = nil

  all_animations.attack.dont_repeat()

  return all_animations
end

function enemies_animations.new_boss_02_animations()
  local animations_level = {}

  local normal_sprites_level_01 =
  {
    boss_sprites.boss_02.level_01.normal.quad_01,
    boss_sprites.boss_02.level_01.normal.quad_02
  }
  animations_level.level_01 = {}
  animations_level.level_01.normal = Animation.new(normal_sprites_level_01, 0.15)
  animations_level.level_01.attack = nil
  animations_level.level_01.die = nil

  local normal_sprites_level_02 =
  {
    boss_sprites.boss_02.level_02.normal.quad_01,
    boss_sprites.boss_02.level_02.normal.quad_02
  }
  animations_level.level_02 = {}
  animations_level.level_02.normal = Animation.new(normal_sprites_level_02, 0.15)
  animations_level.level_02.attack = nil
  animations_level.level_02.die = nil

  return animations_level
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

function power_ups_animations.new_power_02_animation()
  local sprites =
  {
    power_ups_sprites.power_02
  }
  return Animation.new(sprites, 0.2)
end

function power_ups_animations.new_power_03_animation()
  local sprites =
  {
    power_ups_sprites.power_03
  }
  return Animation.new(sprites, 0.2)
end

function power_ups_animations.new_power_04_animation()
  local sprites =
  {
    power_ups_sprites.power_04
  }
  return Animation.new(sprites, 0.2)
end

function power_ups_animations.new_power_05_animation()
  local sprites =
  {
    power_ups_sprites.power_05
  }
  return Animation.new(sprites, 0.2)
end

function power_ups_animations.new_power_06_animation()
  local sprites =
  {
    power_ups_sprites.power_06
  }
  return Animation.new(sprites, 0.2)
end

function new_debris_animation(debri)
  local sprites =
  {
    debris_sprites[debri]
  }
  return Animation.new(sprites, 0.1)
end

function new_left_charger_animation()
  local sprites =
  {
    charger_sprites.left.quad_01,
    charger_sprites.left.quad_02
  }
  return Animation.new(sprites, 0.05)
end

function new_right_charger_animation()
  local sprites =
  {
    charger_sprites.right.quad_01,
    charger_sprites.right.quad_02
  }
  return Animation.new(sprites, 0.05)
end

-- load all fonts
function load_all_fonts()
  local path = 'res/fonts/'

  for size_name, size in pairs(font_sizes) do
    fonts.normal[size_name] = love.graphics.newFont(path..'roboto-regular.ttf', size)
    fonts.black[size_name] = love.graphics.newFont(path..'roboto-black.ttf', size)
    fonts.thin[size_name] = love.graphics.newFont(path..'roboto-thin.ttf', size)
  end
end
