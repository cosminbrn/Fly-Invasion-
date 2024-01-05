function love.load()

  --Libraries
  Object = require "classic"
  lume = require "lume"
  
  --Other lua files
  require "entity"
  require "platform"
  require "player"
  require "bullet"
  require "enemy"
  require "powerup"
  
  love.audio.setVolume(0.1)
  song  = love.audio.newSource("sounds/mixkit-game-level-music-689.wav", "stream")
  song:setLooping(true)
  song:play()
  
  drums = love.audio.newSource("sounds/drums.wav","static")
  jump = love.audio.newSource("sounds/jump.wav","static")
  dead = love.audio.newSource("sounds/dead.wav","static")
  shoot1 = love.audio.newSource("sounds/shot.wav","static")
  shoot2 = love.audio.newSource("sounds/shot.wav","static")
  shoot3 = love.audio.newSource("sounds/shot.wav","static")
  shoot4 = love.audio.newSource("sounds/shot.wav","static")
  shoot = {shoot1,shoot2,shoot3,shoot4}
  sound = love.audio.newSource("sounds/sound.wav","static")
  
  screen={}
  screen.height = love.graphics.getHeight()
  screen.width = love.graphics.getWidth()
  screen.current_left = 0
  screen.current_right = 910
  
  player = Player(100,300)
  
  --A table with all the images used for the grass platforms
  grass = {
    "images/grass_middle.png", -- 1
    "images/grass_left.png", -- 2
    "images/grass_right.png", -- 3
    "images/grass_dirt.png", -- 4
    "images/grassCliffLeftAlt.png", -- 5
    "images/grassCliffRightAlt.png" -- 6
  }
  stone = {
    "images/dirtMid.png", --1
    "images/dirtLeft.png", --2
    "images/dirtRight.png", --3
    "images/dirtCenter.png" --4
  }
  --A table with all the images used for the background
  background = {
    "images/liquidWater.png", -- 1
    "images/liquidWaterTop.png", -- 2
    "images/box.png", -- 3
    "images/boxAlt.png", -- 4
    "images/plant.png", -- 5
    "images/cloud1.png", -- 6
    "images/cloud2.png", -- 7
    "images/cloud3.png", -- 8
    "images/rock.png", -- 9
    "images/plantPurple.png" --10
  }
    
  --Map Blueprint
  tilemap = {
    {0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, --1
    0,0,0,0,0,0,0,0,0,0,0,0,16},
    
    {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, --2
    },
    
    {0,0,0,0,0,0,0,18,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, --3
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16},
    
    {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,--4
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,17},
    
    {0,0,0,0,0,0,0,0,0,0,0,0,17,0,0,0,0,0,0,0,0,0,0,0,0,0, --5
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,18,},
    
    {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, --6
    0,0,0,0,17,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,18,},
    
    {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16,0,0,0, --7
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16,},
    
    {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, --8
    0,0,0,0,0,0,0,0,0,0,0,18,},
    
    {1,0,0,0,0,0,0,18,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, --9
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,17,0,0,0,0,0,0,0,0},
    
    {4,0,0,0,0,0,0,0,0,0,0,0,0,15,0,15,0,0,0,0,0,0,0,0,0,0, --10
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,18,0,0,0.},
    
    {4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,19,0,0,14,14,14,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,14,14,0,0,0,15,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,},
    
    {4,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1, --12
  1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,13,13,13,19,13,13,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,},
    
    {4,19,0,13,13,14,0,0,0,0,0,0,0,4,4,4,4,4,4,4,4,4,4,4,4,4, --13
  4,0,0,0,0,0,15,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4},
    
    {1,1,1,1,1,1,1,1,0,0,0,0,0,4,4,4,4,4,4,4,4,4,4,4,4,4,4,0,0,0,0,0,0,0,15,0,0,0,0,0,0,0,0,0,0,0,0,0,4,4,4,4,4,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,},
    
    {4,4,4,4,4,4,4,4,0,0,0,0,0,4,4,4,4,4,4,4,4,4,4,1,1,4,4,0,0,0,0,2,1,1,0,0,0,15,0,0,0,0,0,0,0,0,0,0,0,4,4,4,4,4,0,0,0,0,0,1,19,0,0,0,0,0,0,0,0,0,0,4,},
    
    {1,1,1,1,4,4,4,4,0,0,0,0,0,4,4,4,4,4,4,4,4,4,4,4,4,4,4,0,0,0,0,0,4,4,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,4,4,0,0,0,0,0,0,4,1,1,19,0,19,0,20,0,20,0,0,4,},
    
    {4,4,4,4,4,4,4,4,12,12,12,12,12,4,4,4,4,4,1,1,1,1,1,1,1,1,4,0,0,0,0,0,4,4,4,4,1,1,1,1,1,0,0,0,0,0,0,0,0,0,4,4,0,0,0,0,0,0,0,4,4,4,1,1,1,1,1,1,1,1,1,4,},
    
    {4,4,4,4,4,4,4,4,11,11,11,11,11,4,4,4,4,4,4,4,4,4,4,4,4,4,4,0,0,0,0,0,4,4,4,4,4,4,4,4,4,0,0,0,0,0,0,0,0,0,4,4,0,0,0,0,0,0,0,4,4,4,4,4,4,4,4,4,4,4,4,4,},
    
    {4,4,4,4,4,4,4,4,11,11,11,11,11,4,4,4,4,4,4,4,4,4,4,4,4,4,4,0,0,0,0,0,4,4,4,4,4,4,4,4,4,0,0,0,0,1,1,1,1,1,4,4,0,0,0,0,0,0,0,4,4,4,4,4,4,4,4,4,4,4,4,4,},
  
    {4,4,4,4,4,4,4,4,11,11,11,11,11,4,4,4,4,4,4,4,4,4,4,4,4,4, --20
    4,0,0,0,0,0,4,4,4,4,4,4,4,4,4,0,0,0,0,4,4,4,4,4,4,4,0,0,0,0,0,0,0,4,4,4,4,4,4,4,4,4,4,4,4,4,}
    
  }
  --Platform and background tables
  platform = {}
  background_things = {}
  --Insert map elements in their respective tables
  for i,v in ipairs(tilemap) do
    for j,w in ipairs(v) do
      if w ~= 0 then
        if w < 10 then
          table.insert(platform, Platform((j-1)*35, (i-1)*35 + 0, grass[w]))
        elseif w > 10 and w <= 20 then
          table.insert(background_things, Platform((j-1)*35, (i-1) * 35 + 0, background[w - 10]))
        elseif w > 20 and w < 30 then
          table.insert(platform, Platform((j-1)*35, (i-1)*35 + 0, stone[w - 20]))
        end
      end
    end
  end
  --Tables for enemies and bullets     
  listOfBullets = {}
  listOfEnemies = {}
  --Timer for enemy spawning
  EnemyTimer = 700
  
  --Fish
  fish_frames = {"images/fishSwim1.png", "images/fishSwim2.png"}
  fish1 = {}
  fish2 = {}
  fish1.x = 315
  fish1.y = 595
  
  fish2.y = 665
  fish1.image = love.graphics.newImage(fish_frames[1])
  fish2.image = love.graphics.newImage(fish_frames[2])
  fish1.width = fish1.image:getWidth()
  fish1.height = fish1.image:getHeight()
  fish2.x = 390
  fish1.speed = 50
  fish2.speed = -50
  
  GameTimer = 0
  copy = GameTimer
  score = 0
  highscore = 0 
  if love.filesystem.getInfo("savedata.txt") then
    file = love.filesystem.read("savedata.txt")
    data = lume.deserialize(file)
    highscore = data.score
  end
  
  powerup_images = {
    "images/gemRed.png", -- 1
    "images/gemYellow.png", -- 2
    "images/gemBlue.png", -- 3
    "images/gemGreen.png" -- 4
  }
  
  powerupDuration = 0
  powerupTimer = 10
  k = 1
  
  
  
  bulletDamage = 1
  bulletColor = 0
  multiplier = 1
  reverse_check = 0
  cap = 0
  
  
  
  
  dead_state = 0
  
  tips = 8
  
  love.graphics.setBackgroundColor(135/255,206/255,210/255)
end


function math.sign(x)
	return (x >= 0) and 1 or -1
end

function saveScore(score)
  data = {}
  data.score = score
  serialized = lume.serialize(data)
  love.filesystem.write("savedata.txt", serialized)
end

function love.mousepressed(x,y,button,istouch)
  if player.x > screen.width / 2 and player.x < 2520 - screen.width / 2 then
    x = x + player.x - screen.width/2
  elseif player.x >= 2520 - screen.width / 2 then
    x = x + 2520 - screen.width
  end
  if button == 1 and cap <= 0 and dead_state == 0 then
    for i,v in ipairs(shoot) do
      if not v:isPlaying() then
        v:play()
        break
      end
    end
    table.insert(listOfBullets, Bullet(player.x + player.width / 2 - 10, player.y + player.height / 2 - 10, "images/bullett.png", x, y, player.origin_x, player.origin_y))
    cap = 0.15 * player.cap_multiplier
  end
end
   
function reversePowerups()
  bulletDamage = 1
  bulletColor = 0
  player.speed = 200
  multiplier = 1
  player.cap_multiplier = 1
end

function love.update(dt)
  
  tips = tips - dt
  --print(screen.current_left,screen.current_right)
  cap = cap - dt
  powerupTimer = powerupTimer - dt
  if powerupTimer <= 0 then
    if k == 1 then
      k = 0
      kind = love.math.random(1,4)
      powerup = Powerup(love.math.random(screen.current_left - 200,screen.current_right + 220), 10, powerup_images[kind])
    end
    powerup:update(dt)
    if powerup:checkCollision(player) then
      powerupTimer = 15
      k = 1
      if kind == 1 then
        bulletDamage = 2
        bulletColor = 1
      elseif kind == 2 then
        player.cap_multiplier = 0
        bulletColor = 2
      elseif kind == 3 then
        player.speed = 300
        bulletColor = 3
      else
        multiplier = 2
        bulletColor = 4
      end
      powerupDuration = 10
    end
  end
  
  if powerupDuration > 0 then
    powerupDuration = powerupDuration - dt
  elseif powerupDuration < 0 then
    reversePowerups()
    powerupDuration = 0
  end

  GameTimer = GameTimer + dt
  if math.floor(copy) ~= math.floor(GameTimer) then
    score = score + 10 * multiplier
  end
  copy = GameTimer
  
  
  EnemyTimer = EnemyTimer - dt * 100
  if EnemyTimer <= 0 then
    if dead_state == 0 then
      table.insert(listOfEnemies, Enemy(love.math.random(screen.current_left - 200,screen.current_right + 200),10))
    end
    EnemyTimer = love.math.random(100,300)
  end
  
  player:update(dt)
  
  for i,v in ipairs(platform) do
    player:resolveCollision(v)
    if powerupTimer <= 0 then
      if powerup:checkCollision(v) then
        powerupTimer = 5
        k = 1
      end
    end
  end
  
  for i,v in ipairs(listOfBullets) do
    v:update(dt)
    for j,w in ipairs(platform) do
      if v:checkCollision(w) then
        table.remove(listOfBullets,i)
      end
    end
    if v.x <= player.x - 709 or v.x >= player.x + 700 or v.y < -100 or v.y > screen.height then
      table.remove(listOfBullets, i)
    else
      for j,w in ipairs(listOfEnemies) do
        
        if v:checkCollision(w) then
          w.lives = w.lives - bulletDamage
          table.remove(listOfBullets, i)
          if w.lives < 1 then
            dead:play()
            table.remove(listOfEnemies, j)
            score = score + 50 * multiplier
          end
        end
      end
    end
  end
  for i,v in ipairs(listOfEnemies) do
    v:update(dt, player.x, player.y)
    if player:checkCollision(v) then
      if not love.filesystem.getInfo("savedata.txt") or           highscore < score then
        saveScore(score)
      end
      dead_state = 1
      love.audio.stop()
      drums:play()
    end
  end
  if player.y > 1000 then
    if not love.filesystem.getInfo("savedata.txt") or           highscore < score then
        saveScore(score)
      end
    dead_state = 1
    love.audio.stop()
    drums:play()
  end
  
  
  
  
  --Fish
  if fish1.x < 315 and math.sign(fish1.speed) == -1 then
    fish1.speed = fish1.speed * (-1)
    
  elseif fish1.x + fish1.width > 480 and math.sign(fish1.speed) == 1 then
    fish1.speed = fish1.speed * (-1)
    
  end
  if fish2.x < 315 and math.sign(fish2.speed) == -1 then
    fish2.speed = fish2.speed * (-1)
   
  elseif fish2.x + fish1.width > 480 and math.sign(fish2.speed) == 1 then
    fish2.speed = fish2.speed * (-1)
  
  end
  
  fish1.x = fish1.x + fish1.speed * dt
  fish2.x = fish2.x + fish2.speed * dt
  
end





function love.draw()
  if tips >= 0 then
    love.graphics.print("Use A,D,Space to move. Click to shoot.",70,150,0,1,1)
    love.graphics.print("Powerups in the form of gems will fall randomly from the sky!", 70, 175, 0, 1, 1)
    love.graphics.print("Blue = Movement Speed",70,200,0,1,1)
    love.graphics.print("Red = Double Damage",70,225,0,1,1)
    love.graphics.print("Yellow  = No Firing Speed Limit",70,250,0,1,1)
    love.graphics.print("Green = Double Score",70,275,0,1,1)
  end
  
  
  if bulletColor == 4 then
    love.graphics.setColor(0,0.6,0)
  end
  if player.x > screen.width / 2  and player.x < 2520 - screen.width / 2 then
    love.graphics.translate(-player.x + screen.width/2,0)
    
    screen.current_left = 0 + player.x - screen.width / 2
    screen.current_right = 910 + player.x - screen.width / 2
    love.graphics.print("Current Score:" .. score, 10 + player.x - screen.width/2, 10)
    love.graphics.setColor(1,1,1)
    love.graphics.print("Highscore:" .. highscore, 10 + player.x - screen.width/2, 30)
  elseif player.x >= 2520 - screen.width/2 then
    screen.current_right = 2520
    screen.current_left = 2520 - screen.width
    love.graphics.translate(-2520 + screen.width ,0)
    love.graphics.print("Current Score:" .. score, 10 + screen.current_left, 10)
    love.graphics.setColor(1,1,1)
    love.graphics.print("Highscore:" .. highscore, 10 + screen.current_left, 30)
  else
    love.graphics.print("Current Score:" .. score, 10, 10)
    love.graphics.setColor(1,1,1)
    love.graphics.print("Highscore:" .. highscore, 10, 30)
  end
  
  
  love.graphics.draw(love.graphics.newImage("images/hill_large.png"), 70, 315, 0, 1, 1)
  love.graphics.draw(love.graphics.newImage("images/hill_large.png"), 1350, 420, 0, 1, 1)
  love.graphics.draw(love.graphics.newImage("images/hill_large.png"), 1120, 350, 0, 1, 1)
  
  
  
  for i,v in ipairs(platform) do
    if v.x >= player.x - screen.width and v.x <= player.x + screen.width then
      v:draw()
    end
  end
  for i,v in ipairs(background_things) do
    if v.x >= player.x - screen.width and v.x <= player.x + screen.width then
     v:draw() 
    end
  end
  
  if bulletColor == 3 then
    love.graphics.setColor(0.25, 0.06, 0, 0.1)
  end
  if dead_state == 0 then
    player:draw()
  elseif score < highscore then
    love.graphics.print("You died! Press Space to restart", screen.current_left + 200, screen.height / 2 - 100,0, 1, 1)
  else
    love.graphics.print("New highscore achieved! Press Space to restart", screen.current_left + 200, screen.height / 2 - 100,0, 1, 1)
  end
  
  love.graphics.setColor(1,1,1)
  
  if bulletColor == 1 then
    love.graphics.setColor(0.6, 0, 0)
  elseif bulletColor == 2 then
    love.graphics.setColor(0.6, 0.6, 0)
  end
  for i,v in ipairs(listOfBullets) do
    v:draw()
  end
  love.graphics.setColor(1,1,1)
  
  for i,v in ipairs(listOfEnemies) do
    v:draw()
  end
  if fish1.x >= player.x - screen.width and fish1.x <= player.x + screen.width or fish2.x >= player.x - screen.width and fish2.x <= player.x + screen.width then
    love.graphics.draw(fish1.image, fish1.x, fish1.y, 0, math.sign(fish1.speed) * (-1), 1, fish1.width / 2)
    love.graphics.draw(fish2.image, fish2.x, fish2.y, 0, math.sign(fish2.speed) * (-1), 1, fish1.width / 2)
  end
  if powerupTimer <= 0 then
    powerup:draw()
  end
end

function love.keypressed(key)
  if key == "f5" then
    love.event.quit("restart")
  elseif (key == "space" or key == "w")  and dead_state == 0 then
    if player.canJump then
      jump:play()
      player.gravity = -600
      player.canJump = false
    end
  elseif (key == "space" or key == "w") and dead_state == 1 then
    love.audio.stop()
    love.load()
  end
end


