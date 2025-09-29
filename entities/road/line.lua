Line = Class {}

function Line:init(x, y)
    self.width = 90
    self.height = 15
    if x then
        self.x = x
    else
        self.x = love.graphics.getWidth() + 10 -- Default: Apenas fuera de pantalla
    end
    if y then
        self.y = y
    else
        self.y = (love.graphics.getHeight() / 2) - (self.height / 2)
    end
    self.speed = 1000
end

function Line:update(dt)
    self.x = self.x - (self.speed * dt)
end

function Line:draw()
    love.graphics.setColor(0.7, 0.7, 0.7)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

-- function Line:setSpeed(newSpeed)
--     self.speed = newSpeed
-- end
