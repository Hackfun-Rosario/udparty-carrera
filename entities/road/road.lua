Class = require 'class'
local utils = require "utils/utils"
require "entities/road/line"
require "entities/road/pavement"

Road = Class {}

-- TODO: Probar en netbooks y otros tamaños de pantalla
local listOfLines = {
    Line(love.graphics.getWidth() - 270),
    Line(love.graphics.getWidth() - 540),
    Line(love.graphics.getWidth() - 810),
    Line(love.graphics.getWidth() - 1080),
}
local pavementSegments = {

}

function Road:init()
    -- Centro verticalmente en la pantalla
    self.center = love.graphics.getHeight() / 2
    -- self.height = love.graphics.getHeight() / 3
end

function Road:update(dt)
    for k, v in pairs(listOfLines) do
        v:update(dt)
    end

    for k, v in pairs(pavementSegments) do
        v:update(dt)
    end

    self:pavementGenerator(dt, 0.3)
    self:linesGenerator(dt, 0.25)
end

function Road:draw()
    love.graphics.setBackgroundColor(0.1, 0.3, 0.1)

    for k, v in pairs(pavementSegments) do
        v:draw()
    end

    for k, v in pairs(listOfLines) do
        v:draw()
    end
end

function Road:_createLineAt(x)
    line = Line(x, self.center)

    table.insert(listOfLines, line)
    if #listOfLines > 8 then
        table.remove(listOfLines, 1)
    end
end

function Road:_createPavementAt(x)
    pavement = Pavement(x, self.center)

    table.insert(pavementSegments, pavement)
    if #pavementSegments > 8 then
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

local linesCountdownTime = 0

function Road:linesGenerator(dt, secs)
    linesCountdownTime = linesCountdownTime - dt
    if linesCountdownTime <= 0 then
        self:_createLineAt()
        linesCountdownTime = linesCountdownTime + secs
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
