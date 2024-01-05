Powerup = Entity:extend()

function Powerup:new(x, y, image_path)
  Powerup.super.new(self, x, y, image_path)
  self.weight = 100
  self.scale = 1
end

function Powerup:update(dt)
  self.last.x = self.x
  self.last.y = self.y
  
  self.gravity = self.gravity + self.weight * dt
  self.y = self.y + self.gravity * dt
  
  if self.x <= 50 then
    self.x = 50
  end
  
  if self.gravity > 150 then
    self.gravity = 150
  end
end