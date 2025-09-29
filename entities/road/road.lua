Class = require 'class'
require "entities/road/line"

Road = Class {}
countdownTime = 0

function Road:init()
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

    timer(dt, 0.3)
end

function Road:draw()
    love.graphics.setBackgroundColor(0.13, 0.13, 0.13)

    for k, v in pairs(listOfLines) do
        v:draw()
    end
end

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

function Road:shrink(percentOfScreenHeight)
end

function Road:enlarge(percentOfScreenHeight)
end

function Road:curveLeft(difficulty)
end

function Road:curveRight(difficulty)
end
