local tick = require 'tick'
local socket = require "socket"
local udp

Class = require 'class'
require "entities/car"

function love.load(filtered_args, args)
    love.window.setFullscreen(true)
    love.window.setVSync(0)
    tick.framerate = 60

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

    car = Car()
end

function love.update(dt)
    -- print(love.timer.getFPS())
    while true do
        local data = udp:receive(20)

        print(data)

        if data then
            car:update(dt, data)
        else
            -- Salir del bucle si no hay más mensajes para no bloquear el thread
            break
        end
    end

    car:update(dt, nil)
end

function love.draw()
    love.graphics.setBackgroundColor(0.13, 0.13, 0.13)
    car:draw()
end

function love.keypressed(key, scancode, isrepeat)
    if key == "q" then
        udp:close()
        love.event.quit()
    end
end
