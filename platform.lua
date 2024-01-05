Platform = Entity:extend()

--70x70

function Platform:new(x, y, image_path)
  Platform.super.new(self, x, y, image_path)
  self.scale = 0.5
  if image_path == "images/plant.png" then
    self.scale = 1
  end
  self.power = 0
  self.weight = 0
  self.width = self.image:getWidth() / 2
  self.height = self.image:getHeight() / 2
end

