require "enemy"

EnemiesController = {}

function EnemiesController.new()
    local self =
    {
        enemies = {}
    }

    function self.create_enemy(x, y, enemyType)
        x = x or 100
        y = y or 100
        enemyType = enemyType or "eye"
        -- local sprite = self.sprite_of_bullet_type(args.type)
        local enemy = Enemy.new{x=x, y=y}
        table.insert(self.enemies, enemy)
    end
    function self.enemy_on_screen(enemy)
        if inside_screen_width(enemy.body.x) and inside_screen_height(enemy.body.y) then
            return true
        else
            return false
        end
    end
    -- destroy an enemy by id
    function self.destroy_enemy(enemyID)
        table.remove(self.enemies, enemyID)
    end
    -- destroy all enemies on list
    function self.destroy_all_enemies()
        self.enemies = {}
    end

    function self.update(dt)
        for i, enemy in ipairs(self.enemies) do
            enemy.update(dt)
            if not enemy.is_alive() then
                enemy.die()
                self.destroy_enemy(i)
            end
            if not self.enemy_on_screen(enemy) then
                self.destroy_enemy(i)
            end
        end
    end
    function self.draw()
        for i, enemy in ipairs(self.enemies) do
            enemy.draw()
        end
    end

    return self

end