require "sprite"
require "bullet"
require "obstacle"
require "mathUtils"

plane = nil
planeSpeed = 250
obstacles = {}
renderer = nil
isAlive = true
bullets = {}
lastShotTime = 0
function love.load()
  renderer = {screenWidth = love.graphics.getWidth(), screenHeight = love.graphics.getHeight()}
  obstacleImg = love.graphics.newImage("assets/obstacle.png")
  for i = 1, 5 do
    local obstacleSprite = Sprite(renderer, obstacleImg, 20, 20)
    local obstacle = Obstacle(obstacleSprite,  222)
    obstacle.setInitPosition(i) 
    table.insert(obstacles, obstacle)
  end
  plane = Sprite(renderer, love.graphics.newImage("assets/plane.png"), 110, 110)
  plane.x = renderer.screenWidth/2 - plane.width/2
  plane.y = renderer.screenHeight/2 - plane.height/2
  bulletImg = love.graphics.newImage("assets/bullet.png")
end

function love.draw()
  if not isAlive then
    love.graphics.print('Umarles!', 400, 100)
  end
  for i = 1, #bullets do
    love.graphics.draw(bullets[i].sprite.img, bullets[i].sprite.x, bullets[i].sprite.y)
  end
    love.graphics.draw(plane.img, plane.x, plane.y)
    for i = 1, #obstacles do
      local obstacle = obstacles[i].sprite
      love.graphics.draw(obstacle.img, obstacle.x, obstacle.y)
    end
end

function love.update(dt)
  if not isAlive then
    return
  end
  moveObstacle(dt)
  shotResult = (love.timer.getTime() - lastShotTime) * 1000
  if love.keyboard.isDown("space") and shotResult >= 500 then
    local bulletSprite = Sprite(renderer, bulletImg, 10, 26)
    local bullet = Bullet(bulletSprite, 150)
    bullet.setInitPosition(plane)
    table.insert(bullets, bullet)
    lastShotTime = love.timer.getTime()
  end
  if love.keyboard.isDown("left") then
    local moveTo = plane.x - planeSpeed * dt
    if plane.canMoveX(moveTo) then
      plane.x = moveTo
    end
  end
  if love.keyboard.isDown("right") then
      local moveTo = plane.x + planeSpeed * dt 
      if plane.canMoveX(moveTo) then
        plane.x = moveTo
      end
  end
  if love.keyboard.isDown("up") then
      local moveTo = plane.y - planeSpeed * dt 
      if plane.canMoveY(moveTo) then
        plane.y = moveTo
      end
  end
  if love.keyboard.isDown("down") then
      local moveTo = plane.y + planeSpeed * dt 
      if plane.canMoveY(moveTo) then
        plane.y = moveTo
      end
  end
  for i, obstacle in ipairs(obstacles) do
    isAlive = not plane.isColliding(obstacle.sprite)
    if not isAlive then
      break
    end
    for j = 1, #bullets do
      local bullet = bullets[j]
      if bullet.sprite.isColliding(obstacle.sprite) then
        print("Uderzenie")
        table.remove(obstacles, i)
        break
      end
    end
  end
  for j, bullet in ipairs(bullets) do
    bullet.move(dt)
    if bullet.shouldGetDisposed() then
      table.remove(bullets, j)
    end
  end
end


function moveObstacle(dt) 
  for i = 1, #obstacles do
    local obstacle = obstacles[i]
    obstacle.move(dt)
  end
end