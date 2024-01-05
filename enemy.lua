Enemy = Entity:extend()

function Enemy:new(x,y)
  Enemy.super.new(self,x,y,"images/flyFly1.png")
  self.lives = 5
  self.weight = 0
  self.speed = 100
  self.frames = {love.graphics.newImage("images/flyFly1.png"), love.graphics.newImage("images/flyFly2.png")}
  self.currentFrame = 1
end

function Enemy:update(dt, target_x, target_y)
  if self.x <= 50 then
    self.x = 50
  end
  if dead_state == 0 then
    self.x = self.x + self.speed * dt * math.cos(math.atan2(target_y - self.y, target_x - self.x))
    self.y = self.y + self.speed * dt * math.sin(math.atan2(target_y - self.y, target_x - self.x))
    self.currentFrame = self.currentFrame + dt * 10
  end
  if self.currentFrame > 3 then
    self.currentFrame = 1
  end
end

function Enemy:draw()
  love.graphics.draw(self.frames[math.floor(self.currentFrame)], self.x, self.y, 0, self.scale, self.scale)
end