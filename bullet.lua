function Bullet(_sprite, _speed)

    local self = {
        sprite = _sprite,
        speed = _speed;
    }
    function self.move(dt) 
        self.sprite.y = self.sprite.y - self.speed * dt 
    end
    

    function self.setInitPosition(plane) 
        self.sprite.x = plane.x + plane.width/2 - self.sprite.width/2
        self.sprite.y = plane.y - self.sprite.height
    end
    function self.shouldGetDisposed() 
        return self.sprite.y < 0
    end
    return self;
end