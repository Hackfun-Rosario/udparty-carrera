Class = require 'class'
local utils = require "utils/utils"
require "entities/road/line"

Road = Class {}


function Road:init()
    -- Comienzo con líneas sobre la ruta
    -- TODO: Probar en netbooks y otros tamaños de pantalla
    self.top = 10
    self.bottom = love.graphics.getHeight() - 10
    self.linesYPosition = (self.top + self.bottom) / 2 - 7.5

    listOfLines = {
        Line(love.graphics.getWidth() - 270),
        Line(love.graphics.getWidth() - 540),
        Line(love.graphics.getWidth() - 810),
        Line(love.graphics.getWidth() - 1080),
    }
end

function Road:update(dt)
    for k, v in pairs(listOfLines) do
        v:update(dt)
    end

    self:linesGenerator(dt, 0.3)
end

function Road:draw()
    love.graphics.setBackgroundColor(0.13, 0.13, 0.13)

    for k, v in pairs(listOfLines) do
        v:draw()
    end
end

function Road:_createLineAt(x, y)
    line = Line(x, self.linesYPosition)

    table.insert(listOfLines, line)
    if #listOfLines > 8 then
        table.remove(listOfLines, 1)
    end
end

function Road:shrink(percentOfScreenHeight)
end

function Road:enlarge(percentOfScreenHeight)
end

function Road:curveLeft(difficulty)
    if difficulty == "easy" then
        self.linesYPosition = self.linesYPosition - 10
    elseif difficulty == "hard" then
        self.linesYPosition = self.linesYPosition - 30
    end
end

function Road:curveRight(difficulty)
    if difficulty == "easy" then
        self.linesYPosition = self.linesYPosition + 10
    elseif difficulty == "hard" then
        self.linesYPosition = self.linesYPosition + 30
    end
end

function Road:linesGenerator(dt, secs, x, y)
    countdownTime = countdownTime - dt
    if countdownTime <= 0 then
        self:_createLineAt(x, y)
        countdownTime = countdownTime + secs
    end
end
