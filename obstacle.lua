require "mathUtils"

function Obstacle(_sprite, _speed)

    local self = {
        sprite = _sprite,
        speed = _speed;
        positiveX = isPositive(),
        positiveY = isPositive() 
    }
 

    function self.move(dt) 
        local futurePosX = 0
        local futurePosY = 0
        if self.positiveX then
            futurePosX = self.sprite.x  + (self.speed  * dt)
        else
            futurePosX = self.sprite.x  - (self.speed  * dt)
        end
        if self.positiveY then
            futurePosY = self.sprite.y  + (self.speed  * dt)
        else
            futurePosY = self.sprite.y - (self.speed  * dt)
        end
        if self.sprite.canMoveX(futurePosX) and self.sprite.canMoveY(futurePosY) then
            print("can")
            self.sprite.x = futurePosX
            self.sprite.y = futurePosY
        else
            self.positiveX = isPositive()
            self.positiveY = isPositive()
        end
    end
    function self.setInitPosition(firstValue) 
        self.sprite.x = firstValue + 50
        self.sprite.y = firstValue + 50
    end
    return self;
end