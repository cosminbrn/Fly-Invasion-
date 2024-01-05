Entity = Object:extend()

function Entity:new(x, y, image_path)
  self.x = x
  self.y = y
  self.image = love.graphics.newImage(image_path)
  self.width = self.image:getWidth()
  self.height = self.image:getHeight()
  self.power = 100
  self.gravity = 0
  self.weight = 400
  
  self.last = {}
  self.last.x = self.x
  self.last.y = self.y
end

function Entity:update(dt)
  self.last.x = self.x
  self.last.y = self.y
end

function Entity:draw()
  love.graphics.draw(self.image, self.x, self.y, 0, self.scale, self.scale)
end

function Entity:checkCollision(e)
    -- e will be the other entity with which we check if there is collision.
    -- self = x and e = y
    return self.x < e.x + e.width and
    e.x < self.x + self.width and
    self.y < e.y + e.height and
    e.y < self.y + self.height
end

function Entity:wasVerticallyAligned(e)
    -- It's basically the collisionCheck function, but with the x and width part removed.
    -- It uses last.y because we want to know this from the previous position
    return self.last.y < e.last.y + e.height and self.last.y + self.height > e.last.y
end

function Entity:wasHorizontallyAligned(e)
    -- It's basically the collisionCheck function, but with the y and height part removed.
    -- It uses last.x because we want to know this from the previous position
    return self.last.x < e.last.x + e.width and self.last.x + self.width > e.last.x
end

function Entity:resolveCollision(e)
    

    if self:checkCollision(e) then
        self.tempStrength = e.tempStrength
        if self:wasVerticallyAligned(e) then
            if self.x + self.width/2 < e.x + e.width/2 then
                -- Replace these with the functions
                self:collide(e, "right")
            else
                self:collide(e, "left")
            end
        elseif self:wasHorizontallyAligned(e) then
            if self.y + self.height/2 < e.y + e.height/2 then
                self:collide(e, "bottom")
            else
                self:collide(e, "top")
            end
        end
        return true
    end
    return false
end


function Entity:collide(e, direction)
    if direction == "right" then
        local pushback = self.x + self.width - e.x
        self.x = self.x - pushback
    elseif direction == "left" then
        local pushback = e.x + e.width - self.x
        self.x = self.x + pushback
    elseif direction == "bottom" then
        local pushback = self.y + self.height - e.y
        self.y = self.y - pushback
        self.gravity = 0
    elseif direction == "top" then
        local pushback = e.y + e.height - self.y
        self.y = self.y + pushback
    end
end