require "sprite"
 
plane = nil
obstacles = {}
renderer = nil
isAlive = true
function love.load()
  renderer = {screenWidth = love.graphics.getWidth(), screenHeight = love.graphics.getHeight()}
  obstacleImg = love.graphics.newImage("obstacle.png")
  for i = 1, 10 do
    local obstacle = Sprite(renderer, obstacleImg, 20, 20)
    obstacle.x = i + 5
    table.insert(obstacles, obstacle)
  end
  plane = Sprite(renderer, love.graphics.newImage("plane.png"), 110, 110)
  plane.x = renderer.screenWidth/2 - plane.width/2
  plane.y = renderer.screenHeight/2 - plane.height/2
   
end

function love.draw()
  if not isAlive then
    love.graphics.print('Umarles!', 400, 100)
  end
    love.graphics.draw(plane.img, plane.x, plane.y)
    for i = 1, #obstacles do
      local obstacle = obstacles[i]
      love.graphics.draw(obstacle.img, obstacle.x, obstacle.y)
    end
end

function love.update(dt)
  if not isAlive then
    return
  end
  moveObstacle(dt)
    if love.keyboard.isDown("left") then
      local moveTo = plane.x - 100 * dt
      if plane.canMoveX(moveTo) then
        plane.x = moveTo
      end
    end
    if love.keyboard.isDown("right") then
        local moveTo = plane.x + 100 * dt 
        if plane.canMoveX(moveTo) then
          plane.x = moveTo
        end
    end
    if love.keyboard.isDown("up") then
        local moveTo = plane.y - 100 * dt 
        if plane.canMoveY(moveTo) then
          plane.y = moveTo
        end
    end
    if love.keyboard.isDown("down") then
        local moveTo = plane.y + 100 * dt 
        if plane.canMoveY(moveTo) then
          plane.y = moveTo
        end
    end
  for i = 1, #obstacles do
    local obstacle = obstacles[i]
    isAlive = not plane.isColliding(obstacle)
    if not isAlive then
      break
    end
  end
end


function moveObstacle(dt) 
  for i = 1, #obstacles do
    local obstacle = obstacles[i]
    local futurePosX = obstacle.x  + randomNumber(isPositive())
    local futurePosY = obstacle.y + randomNumber(isPositive())
    if obstacle.canMoveX(futurePosX) and obstacle.canMoveY(futurePosY) then
     obstacle.x = futurePosX
     obstacle.y = futurePosY
    end
  end

end

function isPositive() 
  return math.random() > 0.5
end

function randomNumber(isPositive) 
  rand = math.random(1, 5)
  if isPositive then
    return rand
  else 
    return -rand
  end
end