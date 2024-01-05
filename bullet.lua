Bullet = Entity:extend()

function Bullet:new(x, y, image_path, target_x, target_y, origin_x, origin_y)
  Bullet.super.new(self, x, y, image_path)
  self.weight = 0
  self.speed = 700
  self.scale = 1
  self.target_x = target_x
  self.target_y = target_y
  self.origin_x = origin_x
  self.origin_y = origin_y
  self.angle = math.atan2(self.target_y - (self.y + self.height/2), self.target_x - (self.x+self.width/2))
  
end

function Bullet:update(dt)
  self.x = self.x + self.speed * dt * math.cos(self.angle)
  self.y = self.y + self.speed * dt * math.sin(self.angle)
end
-- , math.pi / 2 + self.angle
function Bullet:draw()
  love.graphics.draw(self.image, self.x, self.y, 0, self.scale, self.scale)
end