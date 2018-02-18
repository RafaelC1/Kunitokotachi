currentScreen = 2-- 1 history, 2 menu, 3 sub-menu, 4 game, 5 settings
playerTwo = false
settings = {}
world = {}
translations = {}
moan = {}

--controllers
gameController = {}
bulletsController = {}
enemiesController = {}

--window settings
WIDTH = 800
HEIGHT = 600
TITLE = "Kunitokotachi"
VERSION = 2.0

function love.conf(t)
    t.window.width = WIDTH
    t.window.height = HEIGHT
    t.window.resizable = false
    t.window.title = TITLE
    t.window.version = VERSION
end