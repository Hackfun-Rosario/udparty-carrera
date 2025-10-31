Class = require 'class'
local utils = require "utils/utils"
require "entities/road/pavement"

Road = Class {}

local pavementSegments = {
}

function Road:init()
    -- Centro verticalmente en la pantalla
    self.center = love.graphics.getHeight() / 2
    -- self.height = love.graphics.getHeight() / 3
end

function Road:update(dt)
    for k, v in pairs(pavementSegments) do
        v:update(dt)
    end

    self:pavementGenerator(dt, 1)
end

function Road:draw()
    love.graphics.setBackgroundColor(0.1, 0.3, 0.1)

    for k, v in pairs(pavementSegments) do
        v:draw()
    end

end

function Road:_createPavementAt(x)
    pavement = Pavement(x, self.center)

    table.insert(pavementSegments, pavement)
    if #pavementSegments > 12 then
        table.remove(pavementSegments, 1)
    end
end

function Road:shrink(percentOfScreenHeight)
end

function Road:enlarge(percentOfScreenHeight)
end

function Road:curveLeft(difficulty)
    if difficulty == "easy" then
        self.center = self.center - 5
    elseif difficulty == "hard" then
        self.center = self.center - 10
    end
end

function Road:curveRight(difficulty)
    if difficulty == "easy" then
        self.center = self.center + 5
    elseif difficulty == "hard" then
        self.center = self.center + 10
    end
end

local pavementcountdownTime = 0

function Road:pavementGenerator(dt, secs)
    pavementcountdownTime = pavementcountdownTime - dt
    if pavementcountdownTime <= 0 then
        self:_createPavementAt()
        pavementcountdownTime = pavementcountdownTime + secs
    end
end
