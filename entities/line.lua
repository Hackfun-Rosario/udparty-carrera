Line = Class {}

function Line:init()
    self.width = 90
    self.height = 15
    self.x = love.graphics.getWidth() + 10
    self.y = (love.graphics.getHeight() / 2) - (self.height / 2)
    self.speed = 1000
end

function Line:update(dt)
    self.x = self.x - (self.speed * dt)
end

function Line:draw()
    love.graphics.setColor(0.7,0.7,0.7)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end
