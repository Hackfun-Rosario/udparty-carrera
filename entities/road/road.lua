Class = require 'class'
require "entities/road/line"

Road = Class {}
countdownTime = 0

function createLine()
    local line = Line()
    table.insert(listOfLines, line)
    if #listOfLines > 8 then
        table.remove(listOfLines, 1)
    end
end


function timer(dt, secs)
    countdownTime = countdownTime - dt
    if countdownTime <= 0 then
        createLine()
        countdownTime = countdownTime + secs
    end
end

function Road:init()
    -- self.width = love.graphics.getHeight() / 2
    -- self.x = love.graphics.getWidth() + 10
    -- self.y = (love.graphics.getHeight() / 2) - (self.height / 2)
    -- self.speed = 1000

    listOfLines = {}
end

function Road:update(dt)
    for k, v in pairs(listOfLines) do
        v:update(dt)
    end

    timer(dt, 0.3)
end

function Road:draw()
    -- love.graphics.setColor(0.7,0.7,0.7)
    -- love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)

    for k, v in pairs(listOfLines) do
        v:draw()
    end
end
