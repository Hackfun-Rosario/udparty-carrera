Line = Class {}

function Line:init(initXPosition)
    self.width = 90
    self.height = 15
    self.y = (love.graphics.getHeight() / 2) - (self.height / 2)
    if initXPosition then
        self.x = initXPosition
    else
        self.x = love.graphics.getWidth() + 10  -- Default: Apenas fuera de pantalla
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

function Line:setPosition(x, y)
    self.x = x
    self.y = y
end

function Line:setSpeed(newSpeed)
    self.speed = newSpeed
end
