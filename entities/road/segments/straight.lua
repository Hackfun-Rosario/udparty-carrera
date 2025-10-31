Straight = Class {}

DEFAULT_WIDTH = 1100
DEFAULT_SPEED = 1000

function Straight:init(x, centerY, height, width)
    if x then
        self.x = x
    else
        self.x = love.graphics.getWidth() + 10 -- Default: Apenas fuera de pantalla
    end

    if centerY then
        self.y = centerY - (self.height / 2)
    else
        self.y = (love.graphics.getHeight() / 2) - (self.height / 2) -- Default: Centrado
    end

    if width then
        self.width = width
    else
        self.width = DEFAULT_WIDTH
    end

    if height then
        self.height = height
    else
        self.height = love.graphics.getHeight() / 2  -- Default: Mitad del alto de pantalla
    end


end

function Straight:update(dt)
    self.x = self.x - (self.speed * dt)
end

function Straight:draw()
    love.graphics.setColor(0.2, 0.2, 0.2)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end
