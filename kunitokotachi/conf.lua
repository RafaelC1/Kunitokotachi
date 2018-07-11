game_started  = false
debbuger_mode = true

settings     = {} -- game configurations
translations = {} -- manager all translations
moan         = {}

--controllers
game_controller       = {}
bullets_controller    = {}
enemies_controller    = {}
power_ups_controller  = {}
explosions_controller = {}

splash_screen   = {}
history_screen  = {}

SCREENS =
{
  SPLASH_SCREEN           = 1,
  LOAD_SCREEN             = 2,
  HISTORY_SCREEN          = 3,
  MAIN_MENU_SCREEN        = 4,
  SETTINGS_MENU_SCREEN    = 5,
  PRE_GAME_MENU_SCREEN    = 6,
  GAME_SCREEN             = 7,
  SCORE_SCREEN            = 8
}

CURRENT_SCREEN = SCREENS.SPLASH_SCREEN

WIDTH   = 800
HEIGHT  = 600
TITLE   = "Kunitokotachi"
VERSION = 2.1

function love.conf(t)
  t.window.width      = WIDTH
  t.window.height     = HEIGHT
  t.window.resizable  = false
  t.window.title      = TITLE
  t.window.version    = VERSION
end
