Player = Entity:extend()

function Player:new(x, y)
  Player.super.new(self, x, y, "images/p1_walk01.png")
  self.gravity = 0
  self.weight = 1200
  self.speed = 200
  self.canJump = true
  self.origin_x = 84 / 2
  self.origin_y = 128 / 2
  self.cap_multiplier = 1
  self.maxFrames = 11
  self.frame_width = 72
  self.frame_height = 96
  self.frames = {}
  self.rotate = 1
  for i=1,9 do
    table.insert(self.frames,love.graphics.newImage("images/p1_walk0" .. i .. ".png"))
  end
  table.insert(self.frames,love.graphics.newImage("images/p1_walk10.png"))
  table.insert(self.frames,love.graphics.newImage("images/p1_walk11.png"))
  table.insert(self.frames,love.graphics.newImage("images/p1_jump.png"))
  self.currentFrame = 1
  self.image_index = 0
end

function Player:update(dt)
  
  Player.super.update(self,dt)
  
  
  if love.keyboard.isDown("a") and dead_state == 0 then
    self.x = self.x - self.speed * dt
    self.currentFrame = self.currentFrame + dt * 10
    if self.currentFrame >= 11.8 then 
      self.currentFrame = 1
    end
    self.rotate = -1
  elseif love.keyboard.isDown("d") and dead_state == 0 then
    self.x = self.x + self.speed * dt
    self.currentFrame = self.currentFrame + dt * 10
    if self.currentFrame >= 11.8 then 
      self.currentFrame = 1
    end
    self.rotate = 1
  elseif  self.gravity == 0 then
    self.currentFrame = 8
  end
  
  if dead_state == 0 then
    self.gravity = self.gravity + self.weight * dt
    self.y = self.y + self.gravity * dt
  end
  
  if self.gravity == 0 then
    self.canJump = true
  end
  self.image_index = math.floor(self.currentFrame)
  
  if self.gravity <= 0  then
    self.image_index = 12
  end
end


function Player:draw()
  love.graphics.draw(self.frames[self.image_index], self.x + self.width / 2, self.y, 0, self.rotate, 1, self.width / 2)

end

function Player:collide(e, direction)
    Player.super.collide(self, e, direction)
    if direction == "bottom" then
      self.canJump = true
    elseif direction == "top" then
      self.gravity = 0
    end
end

