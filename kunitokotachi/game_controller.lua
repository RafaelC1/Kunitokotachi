require "player"
require "helpers"
require "sprite_controller"

GameController = {}

function GameController.new()
    local self =
    {
        players = {},
        currentPosition = 0,
        cenarySpeed = 5,
        backMenuTime = 0,
        spawnPos =
        {
            ['player1'] = {x=100, y=900},
            ['player2'] = {x=600, y=900}
        }
    }

    function self.check_distances_enemy_to_bullet()
        if #enemiesController.enemies <= 0 or #bulletsController.bullets.player <= 0 then return end
        for i, enemy in ipairs(enemiesController.enemies) do
            for j, bullet in ipairs(bulletsController.bullets.player) do
                local distance = math.sqrt((enemy.body.x - bullet.body.x)^2 + (enemy.body.y - bullet.body.y)^2)
                if distance < (enemy.body.radio + bullet.body.radio) then
                    enemy.apply_damage(bullet.damage)
                    bulletsController.destroy_bullet(j)
                end
            end
        end
    end
    function self.check_distances_player_to_bullet()
        if #self.players <= 0 or #bulletsController.bullets.enemy <= 0 then return end
        for i, player in ipairs(self.players) do
            for j, bullet in ipairs(bulletsController.bullets.enemy) do
                local distance = math.sqrt((player.body.x - bullet.body.x)^2 + (player.body.y - bullet.body.y)^2)
                if distance < (player.body.radio + bullet.body.radio) then
                    player.apply_damage(bullet.damage)
                    bulletsController.destroy_bullet(j)
                end
            end
        end
    end
    function self.check_distances_player_enemy()
        if #self.players <= 0 or #enemiesController.enemies <= 0 then return end
        for i, player in ipairs(self.players) do
            for j, enemy in ipairs(enemiesController.enemies) do
                local distance = math.sqrt((player.body.x - enemy.body.x)^2 + (player.body.y - enemy.body.y)^2)
                if distance < (enemy.body.radio + player.body.radio) then
                    player.apply_damage(1000)
                end
            end
        end
    end
    -- controll player after he reborn until it get to the middle of screen
    function self.controll_player(player, dt)
        player.up(dt)
        if player.body.y < 500 then
            player.selfController = false
        end
    end
    -- generate players
    function self.create_player(player, args)
        local keys = settings['player'..player]
        local x = self.spawnPos['player'..player].x
        local y = self.spawnPos['player'..player].y
        local character = Player.new{player=player, radio=50, speed=600, sprites=shipSprites, keys=keys}
        table.insert(self.players, character)
        self.teleport_player_to_spawn_pos(character)
    end
    function self.teleport_player_to_spawn_pos(player)
        player.body.x = self.spawnPos['player'..player.player].x
        player.body.y = self.spawnPos['player'..player.player].y
    end
    function self.destroy_player(playerID)
        table.remove(self.players, playerID)
        if #self.players <= 0 then
            self.lose_message()
        end
    end
    -- reset all game variables
    function self.start_game()
        self.create_player(1, {x=100, y=700})
        if playerTwo then self.create_player(2, {x=700, y=700}) end
    end
    function self.go_to_menu()
        currentScreen = 2
    end
    function self.lose_message()
        moan.speak('Higuchi',
            {
                translations.translation_of('Higuchi_dying_message_01'),
                translations.translation_of('Higuchi_dying_message_02'),
                translations.translation_of('Higuchi_dying_message_03')
            },
            {oncomplete=self.go_to_menu}
            )
    end
    function self.inscrease_position(dt)
        self.currentPosition = self.currentPosition + self.cenarySpeed*dt
    end
    function self.update(dt)
        for i, player in ipairs(self.players) do
            player.update(dt)
            if player.selfController then
                self.controll_player(player, dt)
            end
            if not player.is_alive() then
                player.die()
                if player.lives <= 0 then
                    self.destroy_player(i)
                else
                    player.reset()
                    self.teleport_player_to_spawn_pos(player)
                end
            end
        end
        self.check_distances_enemy_to_bullet()
        self.check_distances_player_to_bullet()
        self.check_distances_player_enemy()
        self.inscrease_position(dt)
        backGroundSprite.update(dt)
        -- backGroundSprite.set_y(100)
    end
    function self.draw()
        backGroundSprite.draw{x=0, y=0}
        for i, player in ipairs(self.players) do
            player.draw()
        end
    end

    return self
end