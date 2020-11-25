 function Sprite(renderer, _img, _width, _height)
    local self = {
        x = 0,
        y = 0,
        img = _img,
        width = _width,
        height = _height
    }

    function self.isColliding(otherSprite) 
        return otherSprite.x < self.x + self.width and
        otherSprite.x + otherSprite.width > self.x and
        otherSprite.y < self.y + self.height and
        otherSprite.y + otherSprite.height > self.y
    end

    function self.canMoveX(futurePosX)
        return futurePosX >= 0 and futurePosX < (renderer.screenWidth - self.width)
      end
      
      function self.canMoveY(futurePosY)
      return futurePosY >= 0 and futurePosY < (renderer.screenHeight - self.height)
      end
    return self
end