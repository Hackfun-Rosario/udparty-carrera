Car = Class {}
local utils = require "utils/utils"

function Car:init()
    self.sprite = love.graphics.newImage("assets/auto.png")
    self.width = 117
    self.height = 51
    self.x = (love.graphics.getWidth() / 2) - (self.width / 2)
    self.y = (love.graphics.getHeight() / 2) - (self.height / 2)

    self.dx = 0
    self.dy = 0
end

function Car:collides()
    return false
end

function Car:update(dt, data)
    if self.dy < 0 then
        self.y = math.max(0, self.y + self.dy * dt)
    else
        self.y = math.min(love.graphics.getHeight() - self.height, self.y + self.dy * dt)
    end

    if self.dx < 0 then
        self.x = math.max(0, self.x + self.dx * dt)
    else
        self.x = math.min(love.graphics.getWidth() - self.width, self.x + self.dx * dt)
    end

    if data ~= nil then
        local msgParams = utils.split(data, ',')

        self.dx = tonumber(msgParams[2]) or 0
        self.dy = tonumber(msgParams[3]) or 0
    end

    if self.dx > 75 then
        car:moveRight(60)
    elseif self.dx > 65 then
        car:moveRight(40)
    elseif self.dx > 45 then
        car:moveRight(20)
    elseif self.dx > 25 then
        car:moveRight(10)
    elseif self.dx < -75 then
        car:moveLeft(60)
    elseif self.dx < -65 then
        car:moveLeft(40)
    elseif self.dx < -45 then
        car:moveLeft(20)
    elseif self.dx < -25 then
        car:moveLeft(10)
    else
        car:stopHorizontal()
    end


    if self.dy > 85 then
        car:moveDown(80)
    elseif self.dy > 55 then
        car:moveDown(40)
    elseif self.dy > 35 then
        car:moveDown(20)
    elseif self.dy > 15 then
        car:moveDown(10)
    elseif self.dy < -85 then
        car:moveUp(80)
    elseif self.dy < -55 then
        car:moveUp(40)
    elseif self.dy < -35 then
        car:moveUp(20)
    elseif self.dy < -15 then
        car:moveUp(10)
    else
        car:stopVertical()
    end
end

function Car:moveUp(speed)
    self.dy = -speed
end

function Car:moveDown(speed)
    self.dy = speed
end

function Car:moveLeft(speed)
    self.dx = -speed
end

function Car:moveRight(speed)
    self.dx = speed
end

function Car:stopVertical()
    self.dy = 0
end

function Car:stopHorizontal()
    self.dx = 0
end

function Car:draw()
    love.graphics.draw(self.sprite, self.x, self.y)
end
