--file to manager ao sprites on game
require "helpers"
require "sprite"

--images
backGroundImage = {}
backGroundSprite = {}
bulletsImage = {}
bulletSprites =
{
    ["playerLevel01"] = {},
    ["playerLevel02"] = {},
    ["playerLevel03"] = {},
    ["playerLevel04"] = {},
    ["playerLevel05"] = {}
}

defaultSprite = {}
shipSprites = {}
shootType01 = {}
profile_pics =
{
    ["higuchi"] = {},
    ["himiko"] = {},
    ["major"] = {},
    ["nosinalenus"] = {},
    ["secretary"] = {},
    ["tomoe"] = {}
}

function load_all_sprites()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    --load bullets
    bulletsImage = love.graphics.newImage('res/assets/bullets/bullets1.png')
    backGroundImage = love.graphics.newImage('res/assets/back_ground/BACKGROUNDONE.jpg')

    --load players
    local path = "res/assets/HUD/01.png"
    defaultSprite = love.graphics.newImage(path)
    for i, folder in ipairs({"one", "two", "three"}) do
        shipSprites[i] = {}
        for j = 1, 5 do
            path = string.format("res/assets/ships/%s/%02d.png", folder, i)
           if file_exist(path) then shipSprites[i][j] = love.graphics.newImage(path) end
        end
    end
    define_all_sprites()
end

function update(dt)
    -- body
end
function draw()
    -- body
end

function define_all_sprites()
    bulletSprites.playerLevel01 = Sprite.new(bulletsImage, 0, 0, 150, 50, 50, 8)
    bulletSprites.playerLevel02 = Sprite.new(bulletsImage, 0, 50, 150, 50, 50, 8)
    bulletSprites.playerLevel03 = Sprite.new(bulletsImage, 0, 100, 150, 50, 50, 8)
    bulletSprites.playerLevel04 = Sprite.new(bulletsImage, 0, 150, 150, 50, 50, 8)
    bulletSprites.playerLevel05 = Sprite.new(bulletsImage, 0, 200, 150, 50, 50, 10)
    -- PROBLEMAS COM O SPRITE DO BACKGROUND
    backGroundSprite = Sprite.new(backGroundImage, 0, 600, 600, 800, 600, 0)
end