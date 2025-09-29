local tick = require 'tick'
local socket = require "socket"
local udp

Class = require 'class'
require "entities/car"
-- require "entities/road/line"
require "entities/road/road"

function love.load(filtered_args, args)
    -- love.window.setFullscreen(true)
    love.window.setMode(1024, 600)
    love.window.setVSync(-1)
    tick.framerate = 59

    -- Leer configuración desde archivo
    local success, config = pcall(require, "config")
    if not success then
        print("No se encontró el archivo config.lua:", config)
        config = {}
    end
    if config.port then
        print("Port from config:", config.port)
    else
        print("No se especificó el puerto. Usando valor por defecto 12345")
        config.port = 12345
    end

    -- Socket UDP
    udp = socket.udp()
    udp:setoption("reuseaddr", true)
    local success, err = udp:setsockname("*", config.port)
    if not success then
        print("Error al enlazar socket: ", err)
    else
        print("Escuchando...")
    end
    udp:settimeout(0) -- para que no bloquee el hilo principal
    -- listOfLines = {}
    road = Road()
    car = Car()
end

function love.update(dt)
    -- print(love.timer.getFPS())
    while true do
        local data = udp:receive(20)

        -- print(data)

        if data then
            car:update(dt, data)
        else
            -- Salir del bucle si no hay más mensajes para no bloquear el thread
            break
        end
    end

    car:update(dt, nil)
    road:update(dt)

    -- for k, v in pairs(listOfLines) do
    --     v:update(dt)
    -- end

    -- timer(dt, 0.3)
end

-- function createLine()
--     local line = Line()
--     table.insert(listOfLines, line)
--     if #listOfLines > 8 then
--         table.remove(listOfLines, 1)
--     end
-- end

-- countdownTime = 0
-- function timer(dt, secs)
--     countdownTime = countdownTime - dt
--     if countdownTime <= 0 then
--         createLine()
--         countdownTime = countdownTime + secs
--     end
-- end

function love.draw()
    love.graphics.setBackgroundColor(0.13, 0.13, 0.13)
    -- for k, v in pairs(listOfLines) do
    --     v:draw()
    -- end
    road:draw()
    car:draw()
end

function love.keypressed(key, scancode, isrepeat)
    if key == "q" then
        udp:close()
        love.event.quit()
    end
end
