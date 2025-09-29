Pavement = Class {}

function Pavement:init(x, centerY, height)
    self.width = 300
    if height then
        self.height = height
    else
        self.height = love.graphics.getHeight() / 2
    end
    if x then
        self.x = x
    else
        self.x = love.graphics.getWidth() + 10 -- Default: Apenas fuera de pantalla
    end
    if centerY then
        self.center = centerY - (self.height / 2)
    else
        self.center = (love.graphics.getHeight() / 2) -- Default: Centrado
    end
    self.speed = 1000
end

function Pavement:update(dt)
    self.x = self.x - (self.speed * dt)
end

function Pavement:draw()
    love.graphics.setColor(0.2, 0.2, 0.2)
    love.graphics.rectangle("fill", self.x, self.center, self.width, self.height)
end

-- function RoadSide:setSpeed(newSpeed)
--     self.speed = newSpeed
-- end
